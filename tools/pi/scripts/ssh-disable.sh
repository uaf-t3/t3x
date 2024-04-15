#!/usr/bin/env bash
source $(t3x -T)

if [ -f $HOME/.t3x/nolockdown ]; then
  slow_lol "~/.t3x/nolockdown exists ... skipping lockdown of ssh"
fi

sudo_run "update-rc.d ssh disable" && SSH_DISABLE=true
sudo_run "invoke-rc.d ssh stop" && SSH_STOP=true

if [ "$SSH_STOP" = "true" ] && [ "$SSH_DISABLE" = "true" ]; then
  slow_lol "SSH disabled"
  sleep 1
else
  warn "SSH not fully disabled"
fi
