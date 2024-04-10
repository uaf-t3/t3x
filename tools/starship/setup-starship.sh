#!/usr/bin/bash

# https://starship.rs/

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" &> /dev/null & pwd )"

if type -t $boom; then
  function boom() {
    echo "BOOM: $1"
    exit 1
  }
fi

function starship_install() {
  echo "######################################################"
  echo "Starship install can be done like:"
  echo "         curl -sS https://starship.rs/install.sh | sh"
  echo "######################################################"
  echo "Using a t3x cached copy that has been reviewed"
  cd $SCRIPT_DIR
  ./cache/starship.rs-install.sh
}

# check for the command starship run else report missing
function starship_check() {
  if ! command -v starship &> /dev/null
  then
    echo "starship could not be found install with this command:"
    starship_install
    echo "disable this message by removing the symlink in .bash.d/starship.sh"
  else
    eval "$(starship init bash)"
  fi
}

starship_check
