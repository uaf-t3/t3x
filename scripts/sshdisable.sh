#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

#stop ssh and disable ssh on startup. Requires root privelege
yak "Attempting to disable ssh using sudo to systemctl"
run "sudo systemctl stop ssh.service"
if [ $? -eq 0 ]; then
  yak "Successful stop of running ssh server"
  SSH_STOP=true
else
  boom "Unable to stop ssh" # check if this is valid boom or just info
fi
run "sudo systemctl disable ssh.service"
if [ $? -eq 0 ]; then
  yak "Successful disabling of ssh service on start"
  SSH_DISABLE=true
else
  boom "Unable to disbale sshd" 
fi

if [ "$SSH_STOP" = "true" ] && [ "$SSH_DISABLE" = "true" ]; then
  figlet "Disabled SSH" | lolcat
  sleep 1
else
  warn "SSH not fully disabled"
fi
