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

#loop through possible service files because VNC can create multiple with differing names
for unit_file in /etc/systemd/system/vncserver@*.service; do
    run "sudo systemctl stop $(basename "$unit_file")"
    if [ $? -eq 0 ]; then
        yak "Successfully stopped VNC server: $(basename "$unit_file")"
        VNC_STOP=true
    else
        boom "Unable to stop VNC server: $(basename "$unit_file")"
    fi

    run "sudo systemctl disable $(basename "$unit_file")"
    if [ $? -eq 0 ]; then
        yak "Successfully disabled VNC server on startup: $(basename "$unit_file")"
        VNC_DISABLE=true
    else
        boom "Unable to disable VNC server on startup: $(basename "$unit_file")"
    fi
done

#Check if all VNC servers were successfully stopped and disabled
if [ "$VNC_STOP" = "true" ] && [ "$VNC_DISABLE" = "true" ]; then
  figlet "Disabled VNC" | lolcat
  sleep 1
else
  warn "VNC not fully disabled"
  exit 1
fi

exit 0
