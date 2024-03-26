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

# TODO: nerdfont
function nerdfont_install() {
  #local FONTZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
  #FONTZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Ubuntu.zip"
  FONTZIP_URL_DEFAULT="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/UbuntuMono.zip"
  FONTZIP_URL=${1:-$FONTZIP_URL_DEFAULT}
  local ZIPFILE=$(basename $FONTZIP_URL)
  echo "starting nerdfont install: $ZIPFILE"
  local ZIPCACHE="$HOME/.local/share/fonts/zipcache"
  if [ ! -d "$ZIPCACHE" ]; then
    echo "making ZIPCACHE: $ZIPCACHE"
    mkdir -p "$ZIPCACHE"
  fi

  if ! command -v wget > /dev/null 2>&1 ; then
    echo "missing wget - unable to download"
    echo "fix: sudo apt install wget"
    exit 1
  fi
  pushd . > /dev/null

  cd $ZIPCACHE
  if [ ! -f "$ZIPFILE" ]; then
    echo "downloading $FONTZIP_URL"
    wget --quiet "$FONTZIP_URL" || boom "failed: wget $FONTZIP_URL"
  else
    echo "skipping download (file exists): $FONTZIP_URL"
  fi 
  cd ..
  echo "unzipping $ZIPFILE in `pwd`"
  unzip -n -qq zipcache/$ZIPFILE > /dev/null  
  if [ ! $? -eq 0 ]; then
    boom "failed: unzip zipcache/$ZIPFILE"
  fi
  echo "updating font cache: fc-cache -fv"
  fc-cache -fv > /dev/null 2>&1 || boom "failed: fc-fache -fv"
  popd
}

starship_check
nerdfont_install
