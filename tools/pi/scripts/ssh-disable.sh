#!/usr/bin/env bash
source $(t3x -T)

sudo_run "update-rc.d ssh disable" && SSH_DISABLE=true
sudo_run "invoke-rc.d ssh stop" && SSH_STOP=true

if [ "$SSH_STOP" = "true" ] && [ "$SSH_DISABLE" = "true" ]; then
  figlet "Disabled SSH" | lolcat
  sleep 1
else
  warn "SSH not fully disabled"
fi
