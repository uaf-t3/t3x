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
# Check if 'uiHost' is already configured
if grep -q "^\s*uiHost:" "$SETTINGS_FILE"; then
    # replace all lines with "uihost:" so that they target the loopback interface
    awk '{if ($0 ~ /uiHost:/) print "\tuiHost: \"127.0.0.1\","; else print}' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
    if [ $? -ne 0 ]; then
        echo "Failed to bind node red to be hosted locally. Do not run node red unless remote authentication is enabled."
        exit 1
    else
        echo "Updated 'uiHost' to '127.0.0.1' in the settings file."
    fi
else
    # 'uiHost:' not found; add it to the settings file
    echo -e "\tuiHost: '127.0.0.1'," >> "$SETTINGS_FILE"
    echo "Added 'uiHost' setting to run locally."
fi

#backup this edit
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# comment the password auth section
    awk '/\/\/t3x_tag_pwAuth_begin/ {gsub(/.*/, "\t/\*t3x_tag_pwAuth_begin")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE" 2>/dev/null
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
    awk '/\/\/t3x_tag_pwAuth_end/ {gsub(/.*/, "\tt3x_tag_pwAuth_end\*/")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE" 2>/dev/null
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
nodered_restart_if_running