#!/usr/bin/env bash
source $(t3x -T)

sudo awk '/^# en_US.UTF-8 UTF-8/ { $1 = substr($1, 2); print; next }1' /etc/locale.gen > locale.tmp
sudo mv locale.tmp /etc/locale.gen
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8