#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

# Check if vncserver command exists
if !(command -v vncserver &> /dev/null); then
   warn "VNC server not detected ... exiting"
   exit 0
fi

#stop ssh and disable ssh on startup. Requires root privelege
yak "Attempting to disable all VNC servers using sudo to systemctl"
run "sudo systemctl stop vncserver@*"
if [ $? -eq 0 ]; then
  yak "Successful stop of running VNC server(s)"
  VNC_STOP=true
else
  boom "Unable to stop VNC server(s)" 
fi
run "sudo systemctl disable vncserver@*"
if [ $? -eq 0 ]; then
  yak "Successful disabling of VNC server(s) on start"
  VNC_DISABLE=true
else
  boom "Unable to disable VNC" 
fi

if [ "$SSH_STOP" = "true" ] && [ "$SSH_DISABLE" = "true" ]; then
  figlet "Disabled VNC" | lolcat
  sleep 1
else
  warn "VNC not fully disabled"
  exit 1
fi

exit 0
