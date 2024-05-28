#!/usr/bin/env bash

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

function nodered_restart_if_running
{
  if pgrep -x "node-red" >/dev/null; then
    echo "Outdated Node-RED configuration is still running. Attempting to restart..."
    node-red-restart
    echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
  else
    echo "Node-RED configuration updated."
  fi
}

#get hash of password from user
echo "Please enter a password for Node-RED:"
hashed_password=$(node-red admin hash-pw)

# Backup the original settings file
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# replace password hash
if awk -v hashed_password="$hashed_password" 'BEGIN{sub(/^Password: /, "", hashed_password)} /"password":/ {
    $0 = "\t\t    \"password\": \"" hashed_password "\","
}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"; then
    echo "password updated successfully."
else
    echo "password change was unsuccessful. Restoring old configuration..."
    cp "$SETTINGS_FILE.bak" "$SETTINGS_FILE"
fi

nodered_restart_if_running