#!/usr/bin/env bash
source $(t3x -T)

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
#check uihost not configured
if ! grep -q "^\s*uiHost:" "$SETTINGS_FILE"; then
    info "uiHost not configured. Node-RED may already be unlocked."
fi

# Check if authentication is not enabled by t3x
if grep -q "/\*t3x_tag_pwAuth_begin" "$SETTINGS_FILE" && grep -q "t3x_tag_pwAuth_end\*/" "$SETTINGS_FILE"; then
    # uncomment the password auth section
    awk '/\/\*t3x_tag_pwAuth_begin/ {gsub(/.*/, "\t//t3x_tag_pwAuth_begin")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
    awk '/t3x_tag_pwAuth_end\*\// {gsub(/.*/, "\t//t3x_tag_pwAuth_end")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"
else
    # preconfigured settings are not present
    boom "unable to enable password authentication. Aborting unlock..."
fi

#comment all uiHosts
awk '/^[[:space:]]*uiHost:/ {gsub(/.*/, "\t//uiHost:")}1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

nodered_restart_if_running