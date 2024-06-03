#!/usr/bin/env bash

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

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

# tmp 1 = source, tmp 2 = destination
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp1"
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp2"

# comment all uiHosts
awk '/^[[:space:]]*uiHost:/ {gsub(/^[[:space:]]*uiHost:/, "\t//uiHost:")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"
#update source
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1"

#uncomment loopback uiHost if it exists
if awk '/^[[:space:]]*\/\/uiHost: "127.0.0.1",/ {gsub(/\/\/uiHost: "127.0.0.1",/, "uiHost: \"127.0.0.1\"," )}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"; then
  cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source
  echo "Enabled 'uiHost' setting to run locally."
else
  # '//uiHost: "127.0.0.1",' not found. Append it to settings file.
  echo -e "\tuiHost: '127.0.0.1'," >> "$SETTINGS_FILE.tmp1"
  cp "$SETTINGS_FILE.tmp1" "$SETTINGS_FILE.tmp2" #update destination
  echo "Added 'uiHost' setting to run locally."
fi

# comment the password auth section
    awk '/\/\/t3x_tag_pwAuth_begin/ {gsub(/.*/, "\t/*t3x_tag_pwAuth_begin")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2" 2>/dev/null
    cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source
    awk '/\/\/t3x_tag_pwAuth_end/ {gsub(/.*/, "\tt3x_tag_pwAuth_end*/")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2" 2>/dev/null
    cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source


cp "$SETTINGS_FILE" "$SETTINGS_FILE.old" #backup copy
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE" #apply destination to primary config
rm $SETTINGS_FILE.tmp1 $SETTINGS_FILE.tmp2 #cleanup
nodered_restart_if_running