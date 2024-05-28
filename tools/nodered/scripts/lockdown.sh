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

# Backup the original settings file
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# comment all uiHosts
awk '/^[[:space:]]*uiHost:/ {gsub(/^[[:space:]]*uiHost:/, "\t//uiHost:")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
#update backup
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

#uncomment loopback uiHost if it exists
if awk '/^[[:space:]]*\/\/uiHost: "127.0.0.1",/ {gsub(/\/\/uiHost: "127.0.0.1",/, "uiHost: \"127.0.0.1\"," )}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"; then
  cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
  echo "Enabled 'uiHost' setting to run locally."
else
  # '//uiHost: "127.0.0.1",' not found. Append it to settings file.
  echo -e "\tuiHost: '127.0.0.1'," >> "$SETTINGS_FILE"
  echo "Added 'uiHost' setting to run locally."
fi
#update backup
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# comment the password auth section
    awk '/\/\/t3x_tag_pwAuth_begin/ {gsub(/.*/, "\t/*t3x_tag_pwAuth_begin")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE" 2>/dev/null
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
    awk '/\/\/t3x_tag_pwAuth_end/ {gsub(/.*/, "\tt3x_tag_pwAuth_end*/")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE" 2>/dev/null
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
nodered_restart_if_running