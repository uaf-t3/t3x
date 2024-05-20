#!/bin/bash

#install or update node red
#skips confirmations
#commented out for debugging
#bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-root --confirm-install --confirm-pi --no-init

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

# Backup the original settings file
cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

# Check if 'uiHost' is already configured
if grep -q "uiHost" "$SETTINGS_FILE"; then
    # 'uiHost' is found; ensure it's set to '127.0.0.1'
    awk '/uiHost/ && !/127.0.0.1/ {sub(/uiHost:.*/, "uiHost: \'127.0.0.1\',")} 1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
    echo "Updated 'uiHost' to '127.0.0.1' in the settings file."
else
    # 'uiHost' not found; add it to the settings file
    echo "uiHost: '127.0.0.1'," >> "$SETTINGS_FILE"
    echo "Added 'uiHost' setting to run locally."
fi

# Restart Node-RED to apply changes
echo "Attempting to restart Node-RED..."
node-red-restart

echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
