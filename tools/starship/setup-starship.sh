#!/usr/bin/bash
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" &> /dev/null & pwd )"
cd $SCRIPT_DIR

DEFAULT_TOMLFILE=files/starship-t3x.toml
TOMLFILE=${TOMLFILE:-$DEFAULT_TOMLFILE}
export STARSHIP_CONFIG="$SCRIPT_DIR/$TOMLFILE"

echo "### Start: Starship.sh installer & setup"
sleep 0.7

if command -v starship > /dev/null ; then
  echo "Skipping starship install ... starship command available already"
else
  echo "Latest starship installer can be done like this:"
  echo "         curl -sS https://starship.rs/install.sh | sh"
  echo "Using a t3x cached copy that has been reviewed."
  ./cache/starship.rs-install.sh
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
echo "### Finish: Starship.sh setup"
