#!/bin/bash

#Stops Node-RED Service
sudo systemctl stop nodered

# Get the Node-RED user directory
NR_DIR="$HOME/.node-red"
FLOWS_FILE="$NR_DIR/flows.json"

# Check if the file exists
if [[ -f "$FLOWS_FILE" ]]; then
    echo "Found flows.json. Deleting..."
    rm "$FLOWS_FILE" && echo "flows.json deleted successfully." || echo "Failed to delete flows.json."
else
    echo "Error: flows.json not found in $NR_DIR"
    exit 1
fi