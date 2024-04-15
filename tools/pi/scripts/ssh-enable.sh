#!/usr/bin/env bash
source $(t3x -T)

warn "Enabling SSH opens up remote access to the Pi. This is a security concern."
sleep 2
info "Before doing this please review the following:
  - Do you have permission to enable this service on the pi?
  - Have you changed the passwords?
  - Are all the system updates and patches installed?"
sleep 1.5
agree "Continue and enable ssh?"
if [ $? -eq 0 ]; then
  slow_lol "Enabling SSH ... use responsibly"
  sleep 3
else
  cowsay "Good plan... thanks!  Happy hacking"
  exit 0
fi

#echo "TODO: ensure pi password changed"

sudo_run "update-rc.d ssh enable" && SSH_ENABLE=true
sudo_run "invoke-rc.d ssh start" && SSH_START=true

if [ "$SSH_START" = "true" ] && [ "$SSH_ENABLE" = "true" ]; then
  figlet  "SSH started" | lolcat
  sleep 1
else
  warn "SSH not fully enabled"
fi
