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

# Get a list of VNC server unit files
unit_files=$(ls /etc/systemd/system/vncserver@*.service 2>/dev/null)

# Check if any unit files were found
if [ -z "$unit_files" ]; then
    warn "No VNC unit files were found. VNC is not enabled."
    exit 0
fi

# Loop over each VNC unit file and disable it
for unit_file in $unit_files; do
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
