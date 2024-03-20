#!/usr/bin/bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

DEFAULT_MU_VERSION=1.2.0
function download_install_mu() {
  local version=${1:-"$DEFAULT_MU_VERSION"}
  local arch=$(uname -m)
  local arch_normalized
  echo "version=${version} , arch=${arch} , arch_normalized=${arch_normalized}"
  case "$arch" in
    x86_64)
      arch_normalized="x86_64"
      ;;
    aarch64)
      arch_normalized="arm64"
      ;;
    *) 
      echo "Unsupported architecture: $arch"
      return 1
      ;;
  esac
  local DOWNLOAD_URL="https://github.com/mu-editor/mu/releases/download/v${version}/MuEditor-Linux-${version}-${arch_normalized}.tar"

  local FILENAME=$(basename "$DOWNLOAD_URL")
	cd /tmp
	if [ ! -f "$FILENAME" ]; then
		echo "Downloading ${FILENAME} from ${DOWNLOAD_URL}"
		wget -q "$DOWNLOAD_URL"
	fi
	if [ ! -f $FILENAME ]; then
		echo "Download failed! No $FILENAME in `pwd`"
		exit 1
	fi
  echo "$FILENAME downloaded"
  tar xvf $FILENAME
  APPNAME=Mu_Editor-${version}-${arch_normalized}.AppImage
  if [ -f $APPNAME ]; then
    echo "$APPNAME extracted moving to $HOME/Apps"
    if [ ! -d $HOME/Apps ]; then
      mkdir $HOME/Apps
    fi
    mv $APPNAME $HOME/Apps
  else
    echo "FAIL: Did not find $APPNAME"
    exit 1
  fi

  echo $PATH | grep ".local/bin" > /dev/null
  if [ $? -eq 0 ]; then
    echo "adding $APPNAME to $HOME/.local/bin"
    cd $HOME/.local/bin
    if [ -f mu ]; then
      echo "removing existing mu link"
      rm mu
    fi
    ln -s $HOME/Apps/$APPNAME mu
    echo "command: $APPNAME available as mu"
  fi
  return 0
}

function install_deps() {
	dpkg -S libfuse2 > /dev/null
	if [ $? -eq 0 ]; then
		echo "libfuse2 dependancies already installed"
	else
		sudo apt install libfuse2
	fi
}

function check_groups() {
	echo "verifying user is in dialout and uucp groups"
	# groups include dialout?
	groups | grep dialout > /dev/null
	if [ ! $? -eq 0 ]; then
		echo "user is not in the dialout group - adding"
		sleep 0.5
		sudo adduser $USER dialout
		if [ $? -eq 0 ]; then
			echo "added $USER to dialout group"
			echo "TIP: you will need to open new shell and/or login/logout"
    else
      echo "failed to add $USER to dialout group"
    fi
	else
		echo "note: user already in dialout group. Good job!"
	fi
	groups | grep uucp > /dev/null
	if [ ! $? -eq 0 ]; then
		echo "user is not in the uucp group - adding"
		sleep 0.5
		sudo adduser $USER uucp
		if [ $? -eq 0 ]; then
			echo "added $USER to uucp group"
			echo "TIP: you will need to open new shell and/or login/logout"
    else
      echo "failed to add $USER to dialout group"
    fi
	else
		echo "note: user already in dialout group. Good job!"
	fi
}

VERSION=${1:-"$DEFAULT_MU_VERISION"}
echo "Script to install Mu from codewith.mu : 'v$VERSION'"
sleep 0.5
if install_deps; then
  echo "install_deps success"
else
  echo "unable to install dependancies for mu - failing out"
  exit 1
fi

if download_install_mu($VERSION); then
  echo "download_install_mu() success"
else
  echo "FAIL: dwonload_install_mu() failed"
  exit 1
fi

if check_groups; then
  echo "success: check_groups()"
else
  echo "download_install_mu() failed: $0"
  exit 1
fi

exit 0
