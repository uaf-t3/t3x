#!/usr/bin/env bash
source $(t3x -E)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)
# Define the path to the template settings file for Node-RED
SETTINGS_TEMPLATE="$SCRIPT_DIR/../files/node-red-default-settings.js"
#define the path to cache the installer file
CACHED_INSTALLER="$SCRIPT_DIR/../files/update-nodejs-and-nodered"
INSTALLER_URL="https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered"
# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

echo "getting latest Node-RED installer..."
if curl -sL "$INSTALLER_URL" -o "$CACHED_INSTALLER"; then
    echo "Installer downloaded successfully."
else
    echo "Failed to download the installer. Attempting to run cached version..."
fi
if [ -f "$CACHED_INSTALLER" ]; then
    echo "running installer..."
    bash "$CACHED_INSTALLER" --confirm-root --confirm-install --confirm-pi --no-init
else
    echo "Cached Node-RED installer not found. Try connecting to the internet and running it again."
    exit 1
fi

echo "restoring Node-RED settings from t3x default..."
if cp "$SETTINGS_TEMPLATE" "$SETTINGS_FILE"; then
    echo "successfully loaded default settings."
else
    echo "Failed to copy from default settings file. Node-RED may not be locked down. Use the lockdown command to secure Node-RED."
    exit 1
fi

echo "running installer for nodes..."
bash "${SCRIPT_DIR}/node_installer.sh"