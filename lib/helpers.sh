# usage: source lib/helpers.sh
# Dayne's basic shell helpers
# Feel free to use as needed
# Originally devleoped for d.init

function error {
  echo -e "\e[31m\e[1m${1}\e[0m"
  sleep 1
}

function warn {
  echo -e "\e[93m${1}\e[0m"
  sleep 0.5
}

# export T3X_DEBUG=true # to cause info messages to show up
function debug {
  if [ "$T3X_DEBUG" != false ]; then
    echo "# DEBUG: ${1}"
    sleep 0.1
  fi
}

function info {
    echo -e "\e[32m${1}\e[0m"
}

function boom() { 
  error "${1}"
  sleep 1
  exit 1
}

function yak() {
  info "${1}"
  sleep 1 
}

function current_script_dir() {
  echo $(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)  
}

function verify_internet() {
  if $(ping -c 1 google.com > /dev/null); then
    echo "Internet detected"
    return 0
  else
    echo "Unable to ping google.com -- Are you connected to the internet?"
    sleep 1
    if $(ping -c 1 8.8.8.8 > /dev/null); then
      echo "Unable to ping 8.8.8.8 -- likely no internet!"
      sleep 1
      return 1
    else
      return 0
    fi
  fi
}

function apt_update() {
  if verify_internet; then
    echo "Success: verified internet access"
  fi
  local up2date="/tmp/apt-update-success"
  if [ -f /tmp/apt-update-success ]; then
    if test $(stat -c %Y -- "$up2date") -gt $(($EPOCHSECONDS - 3600)); then
      echo "Skipping apt update -- ran within last hour"
      return 0
    fi
  fi
  sudo apt update
  if [ $? -eq 0 ]; then
    touch $up2date
  fi
}

function apt_install() {
  debug "apt_install $1"
  dpkg -s "$1" > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    debug "# sudo apt-get install $1"
    sudo apt-get install -yq "$1"
  else
    info "# skipping apt install $1 ... already installed"
  fi
}

function apt_install_list() {
  pkg_list=$1
  debug "apt_install_list: $pkg_list"
  local missing=()
  local installed=()
  for I in $pkg_list; do 
    dpkg -s "$I" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      missing+=("$I")
    else
      echo "Skipping install (already available): $I"
      installed+=("$I")
    fi
  done
  sleep 0.5
  case ${#missing[@]} in
    0) 
      echo "Success: All packages in list installed already"
      ;;
    *)
      echo "Missing ${#missing[@]} packages: ${missing[@]}"
      sudo apt install "${missing[@]}"
  esac
}

function got_command() {
  which "$1" &> /dev/null
  if [ $? -eq 1 ]; then
    echo "#>> missing command : $1"
    return 1
  else
    echo "#>> command found: $1"
    return 0
  fi
}

function require_command() {
  which "$1" > /dev/null 2>&1
  if [ $? -eq 1 ]; then
    if [ "$2" != "" ]; then
      echo "#>> missing command : $1"
      echo "#>> POSSIBLE FIX: $2"
    fi
    boom "required command not found: $1"
  fi
}

function agree() {
  while( true ); do
    echo -n "$1 : (y/n) : "
    read answer
    if [ $answer == "n" ]; then
      return 1; 
    elif [ $answer == 'y' ]; then
      return 0;
    fi
    echo "invalid answer - provide a 'y' or a 'n'"
    sleep 0.5
  done
}

function run() {
  info "#run() START: $1"
  sleep 0.4
  if [ "$T3X_RUN" = "false" ]; then
    info "#T3X_RUN=false: $1 # fake success"
    info "#run()  FAKE: $1"
    return 0
  fi
  $1
  RETVAL=$?
  if [ $RETVAL -eq 0 ]; then
    info "#run()  DONE: $1"
  else
    warn "#run()  FAIL: $1"
  fi
  return $RETVAL;
}

function sudo_run() {
  echo "SUDO run of: $1"
  sleep 0.5
  run "sudo $1"
}


function run_install_unless() {
  got_command $2
  if [[ $? -eq 0 ]]; then
    echo "#   skipping install: $1"
    return 1
  else
    run "$1"
  fi
}

function ensure_mkdir() {
  if [[ ! -d ${1} ]]; then
    echo "# >> Creating dir: ${1}"
    mkdir -p $1
    if [[ ! $? -eq 0 ]]; then
      boom "ensure_mkdir failed for creating: ${1}"
    fi
  else
    echo "# >> exists .. skipping creation: ${1}"
  fi
}

function cp_file {
  if [[ ! -f $2 ]]; then
    cp -v $1 $2
    
    if [[ -d $2 ]]; then
      target=$2/`basename $1`
    else
      target=$2
    fi

    if [[ ! -f $target ]]; then
      boom "copy of $target failed"
    fi
  else
    echo "# >> exists .. skipping copy ${2}"
  fi
}

function require_root 
{
	if [ $USER != 'root' ]; then
		boom "this script requires root - please run with sudo"
		exit 1
	fi
}

function t3x_scripts_list() {
  SCRIPTS_DIR=${1:-$T3X_SCRIPTS_DIR}
  debug "checking dir for *.t3x: $SCRIPTS_DIR"
  scripts=()
  for script in $(ls $SCRIPTS_DIR/*.t3x 2> /dev/null | sort -n ); do
    debug "$script found"
    script_name=$(basename $script .t3x)
    scripts+=("$script_name")
  done

  case ${#scripts[@]} in
    0) 
      echo   "No scripts available"
      ;;
    1) 
      echo   "Script available: $scripts"
      ;;
    *) 
      echo 
      echo   "Scripts list:     # "
      for script in ${scripts[@]}; do
        echo "   $script"
      done
      #printf "    %s" "${scripts[0]}"    # first element
      #printf ", %s" "${scripts[@]:1}" # remaining elements prefixed by ,
      ;;
  esac
}
