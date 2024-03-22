#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

#stop vnc and disable on startup via raspi-config.
yak "Attempting to disable ssh using sudo to systemctl"
run "sudo raspi-config nonint do_vnc 1"
if [ $? -eq 0 ]; then
  figlet "Disabled VNC" | lolcat
  sleep 1
  SSH_STOP=true
else
  warn "VNC not fully disabled"
fi