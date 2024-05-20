#!/bin/bash

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

#apply the default settings file and install node red. This should be locked down by default.
function install_nodered
{
    echo "restoring node red settings from default.."
    cp "../lib/node-red-default-settings.js" "$SETTINGS_FILE"

    echo "running node red installer..."
    echo bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-root --confirm-install --confirm-pi --no-init
}

# modify the settings to bind node red to be hosted locally, then restart node red to apply the changes.
function lockdown_nodered
{
    # Backup the original settings file
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

    # Check if 'uiHost' is already configured
    if grep -q "uiHost" "$SETTINGS_FILE"; then
        # replace all lines with "uihost" so that they target the loopback interface
        awk '/uiHost:/ {gsub "uiHost: \'127.0.0.1\\',"); print} 1' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
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
}

#install node red
echo "calling installation function..."
install_nodered