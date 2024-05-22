#!/usr/bin/env bash
source $(t3x -E)

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)
# Define the path to the template settings file for Node-RED
SETTINGS_TEMPLATE="$SCRIPT_DIR/../files/node-red-default-settings.js"
# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"

echo "running node red installer..."
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --confirm-root --confirm-install --confirm-pi --no-init

echo "restoring Node-RED settings from t3x default..."
cp "$SETTINGS_TEMPLATE" "$SETTINGS_FILE"
# Check if the cp command succeeded
if [ $? -ne 0 ]; then
    echo "Failed to copy from default settings file. Node-RED may not be locked down. Use the lockdown command to secure Node-RED."
    exit 1
else
    echo "successfully loaded default settings."
fi

echo "running installer for nodes..."
bash "${SCRIPT_DIR}/node_installer.sh"