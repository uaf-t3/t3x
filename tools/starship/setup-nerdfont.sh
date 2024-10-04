#!/usr/bin/bash

# https://starship.rs/

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}")" &> /dev/null & pwd )"

#local FONTZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
#FONTZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Ubuntu.zip"
FONTZIP_URL_DEFAULT="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/UbuntuMono.zip"
FONTZIP_URL=${1:-$FONTZIP_URL_DEFAULT}
ZIPFILE=$(basename $FONTZIP_URL)
FONTNAME=$(basename $ZIPFILE .zip)
echo "### Starting nerd font install of $FONTNAME"

ZIPCACHE="$HOME/.local/share/fonts/zipcache"
if [ ! -d "$ZIPCACHE" ]; then
  echo "making ZIPCACHE: $ZIPCACHE"
  mkdir -p "$ZIPCACHE"
fi

if ! command -v wget > /dev/null 2>&1 ; then
  echo "Fatal: missing wget - unable to download"
  echo "       fix: sudo apt install wget"
  exit 1
fi


cd $ZIPCACHE
if [ -f "$ZIPFILE" ]; then
  echo "Skipping download (file exists): $ZIPFILE"
else
  echo "Starting download $FONTZIP_URL"
  wget --quiet "$FONTZIP_URL" 
  if [ $? -eq 0 ]; then
    echo "Download of font successful!"
  else
    echo "Fatal: Download of font failed: wget $FONTZIP_URL"
    exit 1
  fi
fi 

FONT_TTF=`unzip -l $ZIPFILE | grep \.ttf | head -n 1 | awk '{print $4}'`
if [ -z "${FONT_TTF}" ]; then
  echo "Error finding a TTF font in zip $ZIPFILE"
  echo "  dir: $(pwd)"
  echo "  zip: $ZIPFILE"
  exit 1
fi

cd ..
if [ -f "$FONT_TTF" ]; then
  echo "Skipping unzip of $ZIPFILE ... file exists: $FONT_TTF"
else
  echo "Starting unzip $ZIPFILE in `pwd`"
  unzip -n -qq zipcache/$ZIPFILE > /dev/null  
  if [ ! $? -eq 0 ]; then
    echo "Failed unzip of zipcache/$ZIPFILE"
    exit 1
  fi
  #  
  echo "Starting font cache update: fc-cache -fv"
  fc-cache -fv > /dev/null 2>&1 || "Failed: fc-fache -fv"
  if [ $? -eq 0 ]; then
    echo "Font-cache update completed"
  else
    echo "Font-cache update failed"
  fi
fi

if command -v lxterminal; then
  LXT_CONF="$HOME/.config/lxterminal/lxterminal.conf"
  LXT_DIR=$(dirname $LXT_CONF)
  if [ ! -f "${LXT_CONF}" ]; then
    echo "No lxterminal.conf found ... putting t3x version in place"
    mkdir -p $LXT_DIR
    cp -v $SCRIPT_DIR/files/lxterminal.conf $LXT_DIR/
  else
    echo "Found existing lxterminal.conf ... checking for Nerds"
    if grep "Nerd" $LXT_CONF > /dev/null; then
      echo "Nerds found in lxterminal.conf ... skipping reconfiguring it"
    else
      echo "No nerds found in lxterminal.conf ... backing up & replacing"
      cp -v "$LXT_CONF" "${LXT_CONF}.orig"
      cp -v $SCRIPT_DIR/files/lxterminal.conf $LXT_DIR/
    fi
  fi
else
  echo "Skipping lxterminal configuration ... lxterminal is not installed"
fi


if command -v gucharmap > /dev/null; then # 🐼
  echo "Skipping install: gucharmap already installed"
else
  echo "Missing gucharmap -- for finding all the pandas ... installing"
  sudo apt install gucharmap
fi
