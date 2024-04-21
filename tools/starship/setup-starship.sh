#!/usr/bin/bash
source $(t3x -T)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)
cd $SCRIPT_DIR

# Install for this user ownly to avoid requiring sudo.
BIN_DIR=$HOME/.local/bin
DEFAULT_TOMLFILE=$SCRIPT_DIR/files/starship-t3x.toml
TOMLFILE=${TOMLFILE:-$DEFAULT_TOMLFILE}

if [ ! -f $TOMLFILE ]; then
  echo "Error: STARSHIP_CONFIG toml file does not exist: $TOMLFILE "
  exit 1
fi

export STARSHIP_CONFIG=$TOMLFILE

echo "### Start: Starship.sh installer & setup"
sleep 0.7

if command -v starship > /dev/null ; then
  echo "Skipping starship install ... starship command available already"
else
  echo "Latest starship installer can be done like this:"
  echo "         curl -sS https://starship.rs/install.sh | sh"
  echo "Using a t3x cached copy that has been reviewed."
  ./cache/starship.rs-install.sh -y
  if [ $? -eq 0 ]; then
    echo "Starship install successfull done"
  else
    echo "Starship install failed. Try again"
    sleep 1
    exit 1
  fi
fi

if [ ! -f $STARSHIP_CONFIG ]; then
  echo "404 File Not Found: STARSHIP_CONFIG=$STARSHIP_CONFIG"
  sleep 1
  echo "WARNING: Unable to configure a default starship.toml"
  sleep 1
  echo "WARNING: This means starship won't work right."
else
  if [ -f $HOME/.config/starship.toml ]; then
    echo "Skipping tom config file exists ... ~/.config/starship.toml"
  else
    echo "No default starship.toml detected at ~/.config/starship.toml"
    echo "Putting $STARSHIP_CONFIG as the new default toml"
    cp $STARSHIP_CONFIG $HOME/.config/starship.toml
  fi
fi

if [ ! -d $HOME/.bash.d ]; then
  echo "Fatal: No .bash.d .... this need to be fixed"
  echo "Unable to configure starship to autolaunch"
  sleep 1
  exit 1
fi

if [ ! -f $HOME/.bash.d/starship.sh ]; then
  echo "Setting up starship to autolaunch using .bash.d/starship.sh"
  cp -v files/bash.d.starship.sh $HOME/.bash.d/starship.sh
fi

./setup-nerdfont.sh
if [ $? -eq 0 ]; then
  echo "### Finish: Starship.sh setup"
  exit 0
else
  echo "Error: setup-nerdfont.sh failed ... you may not have needed fonts for full experience"
  exit 1
fi
