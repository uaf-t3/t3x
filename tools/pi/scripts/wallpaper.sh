#!/usr/bin/env bash
source $(t3x -T)

# Change Wallpaper
IMAGE_URL="https://raw.githubusercontent.com/ItalianSquirel/T3-RPi-Image/main/Assets/Wallpapers/t3wallpaper.png"

if [ -d $HOME/Pictures ]; then
  WALLPAPER_DIR=$HOME/Pictures
else
  WALLPAPER_DIR="$HOME/.local/share/rpx/"
fi

WALLPAPER_FILE="$WALLPAPER_DIR/$(basename $IMAGE_URL)"

# Download the image file to the Raspberry Pi
require_command wget
info "Downloading T3 Wallpaper"
if [ ! -d $WALLPAPER_DIR ]; then
  run "mkdir -p $WALLPAPER_DIR"
fi

run "wget -q -O ${WALLPAPER_FILE} ${IMAGE_URL}"
if [ $? -eq 0 ]; then
  yak "T3X wallpaper download success"
else
  boom "Download of wallpaper failed"
fi

if got_command pcmanfm; then
  yak "pcmanfm command found - setting the image file as the wallpaper"
  run "pcmanfm --set-wallpaper=${WALLPAPER_FILE}"
  yak "Refresh the desktop to show the new wallpaper"
  run "pcmanfm -w /"
  cowsay "Look at that" | lolcat
else
  warn "pcmanfm command not found - skipping applying of wallpaper"
  cowsay "Manual wallpaper install time"
  warn "New wallpaper location: $WALLPAPER_FILE"
fi

exit 0
