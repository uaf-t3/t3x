#!/usr/bin/env bash

# Change Wallpaper
IMAGE_URL="https://raw.githubusercontent.com/ItalianSquirel/T3-RPi-Image/main/Assets/Wallpapers/t3wallpaper.png"
WALLPAPER_PATH="/usr/share/rpd-wallpaper/"

# Download the image file to the Raspberry Pi
sudo wget -O $WALLPAPER_PATH"wallpaper.jpg" $IMAGE_URL

# Set the image file as the wallpaper
pcmanfm --set-wallpaper=$WALLPAPER_PATH"wallpaper.jpg"

# Refresh the desktop to show the new wallpaper
pcmanfm -w /