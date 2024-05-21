#!/bin/bash

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

#defind the path to the default settings file
DEFAULT_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib/node-red-default-settings.js"

# Restart Node-RED to apply changes
function restart_nodered
{
    echo "Attempting to restart Node-RED..."
    node-red-restart
    echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
}

#apply the default settings file and install node red.
function install_nodered
{
    echo "running node red installer..."
    bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-root --confirm-install --confirm-pi --no-init

    echo "restoring node red settings from t3x default..."
    cp "$DEFAULT_FILE" "$SETTINGS_FILE"
    # Check if the cp command succeeded
    if [ $? -ne 0 ]; then
        echo "Failed to copy default settings file. This could be due to an unsuccessful or corrupt node-red installation."
        exit 1
    else
        echo "successfully loaded default settings."
    fi
}

# modify the settings to bind node red to be hosted locally, then restart node red to apply the changes.
function lockdown_nodered
{
    # Backup the original settings file
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

    # Check if 'uiHost' is already configured
    if grep -q "uiHost:" "$SETTINGS_FILE"; then
        # replace all lines with "uihost" so that they target the loopback interface
        awk '{if ($0 ~ /uiHost:/) print "\tuiHost: \"127.0.0.1\","; else print}' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
        if [ $? -ne 0 ]; then
            echo "Failed to bind node red to be hosted locally. Do not run node red unless remote authentication is enabled."
        exit 1
        else
            echo "Updated 'uiHost' to '127.0.0.1' in the settings file."
        fi
    else
        # 'uiHost' not found; add it to the settings file
        echo "uiHost: '127.0.0.1'," >> "$SETTINGS_FILE"
        echo "Added 'uiHost' setting to run locally."
    fi
}

# modify the settings to enable password authentication, then restart node red to apply the changes.
function enable_remote_nodered
{
    # Backup the original settings file
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.bak"

    # Check if 'uiHost' is already configured
    if grep -q "uiHost:" "$SETTINGS_FILE"; then
        # replace all lines with "uihost" so that they target the loopback interface
        awk '{if ($0 ~ /uiHost:/) print "\tuiHost: \"127.0.0.1\","; else print}' "$SETTINGS_FILE.bak" > "$SETTINGS_FILE"
        if [ $? -ne 0 ]; then
            echo "Failed to bind node red to be hosted locally. Do not run node red unless remote access feature is enabled intentionally."
        exit 1
        else
            echo "Updated 'uiHost' to '127.0.0.1' in the settings file."
        fi
    else
        # 'uiHost' not found; add it to the settings file
        echo "uiHost: '127.0.0.1'," >> "$SETTINGS_FILE"
        echo "Added 'uiHost' setting to run locally."
    fi
}

#install and lockdown node red
echo "running node red installer..."
install_nodered
echo "locking down node red by binding it to be hosted locally..."
lockdown_nodered
if [ $? -ne 0 ]; then
    echo "Failed to bind node red to be hosted locally. Avoid running node red without setting a password."
    exit 1
else
    echo "restarting node red to apply the changes..."
    restart_nodered
fi