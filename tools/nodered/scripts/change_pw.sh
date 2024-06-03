#!/usr/bin/env bash

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)

function nodered_restart_if_running
{
  if pgrep -x "node-red" >/dev/null; then
    echo "Outdated Node-RED is still running. Attempting to restart..."
    node-red-restart
    echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
  else
    echo "Node-RED configuration updated. It will be applied when Node-RED is started."
  fi
}

#get hash of password from user
echo "Please enter a password for Node-RED:"
hashed_password=$(node-red admin hash-pw)

# tmp 1 = source, tmp 2 = destination
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp1"
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp2"

# replace password hash
if awk -v hashed_password="$hashed_password" 'BEGIN{sub(/^Password: /, "", hashed_password)} /"password":/ {
    $0 = "\t\t    \"password\": \"" hashed_password "\","
}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"; then
    
    echo "password updated successfully."
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.old" #backup copy
    cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE" #apply destination to primary config
    bash "${SCRIPT_DIR}/nodered_restart_if_running.sh"
else
    echo "password change was unsuccessful. No changes were applied."
fi

rm $SETTINGS_FILE.tmp1 $SETTINGS_FILE.tmp2 #cleanup