#!/usr/bin/bash
DEFAULT_TARGET_INSTALL="$HOME/.local/share/dectalk"
TARGET_INSTALL=${TARGET_INSTALL:-$DEFAULT_TARGET_INSTALL}

# exit if any command fails
set -e 

if ! type boom &> /dev/null; then
  # define boom if it isn't defined yet
  function boom() {
    echo "Boom: $1"
    exit 1
  }

fi

APT_DEPS="build-essential libasound2-dev libpulse-dev libgtk2.0-dev unzip git"
MISSING_PKGS=""

for pkg in $APT_DEPS; do
  if ! dpkg -l | grep -qw $pkg; then
    MISSING_PKGS="$MISSING_PGKS $pkg"
  fi
done

if [ -n "$MISSING_PKGS" ]; then
  echo "Installing missing packages: $MISSING_PKGS"
  sudo apt update 
  sudo apt install -y $MISSING_PKGS
else
  echo "All package are already installed .. skipping install"
fi

if [ ! -d $TARGET_INSTALL ]; then
	echo mkdir -p $TARGET_INSTALL
	mkdir -p $TARGET_INSTALL
fi

cd $TARGET_INSTALL || { boom "failed to cd $TARGET_INSTALL"; }

pwd

if [ ! -d .git ]; then
	git clone https://github.com/dectalk/dectalk . || { boom "git clone failed"; }
else 
	echo "skipping clone: dectalk dir exists"
  echo "doing a git pull instead"
  git pull
fi

if [ $? -eq 0 ]; then
	cd src
else
	boom "git clone dectalk failed"
fi

autoconf || { boom "autoconf -si"; }  # -si ??
./configure --prefix=$INSTALL_PREFIX || { boom "./configure --prefix=$INSTALL_PREFIX"; }
make -j || { boom "make -j"; }
cd ../dist
./say -a "hello I am a robot. beep boop" || { boom "./say -a 'hellow I am a robot' "; }
if [ -d $INSTALL_PREFIX/../bin/ ]; then
  ln say $INSTALL_PREFIX/../bin/
else
  echo "say command available in `pwd`"
fi
cd ../src


#echo "# Optional: install dectalk to $INSTALL_PREFIX
#echo " # you can run the following two commands:"
#echo "# cd $INSTALL_PREFIX/src/dectalk/src'
##echo "# make install"
