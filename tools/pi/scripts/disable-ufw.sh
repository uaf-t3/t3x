#!/usr/bin/bash
source $(t3x -T)

echo "disabling ufw"
sudo ufw disable
