#!/usr/bin/env bash
SCRIPT_DIR=$(cd $(dirname $BASH_SOURCE) > /dev/null; pwd)

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# File containing the list of npm packages to install
NODE_LIST="${SCRIPT_DIR}/../files/nodes.txt"

if ! command -v npm > /dev/null; then
  echo "missing npm. Installing via apt"
  sudo apt install npm
fi

# Check if NODE_LIST file exists
if [ ! -f "$NODE_LIST" ]; then
    echo -e "${RED}Error: Node list file does not exist: $NODE_LIST${NC}" >&2
    exit 1
fi

# Temporarily change permissions of node_modules directory so that installers can write to it
sudo mkdir /usr/lib/node_modules
sudo chmod a+w /usr/lib/node_modules

# Loop through the nodes.txt file
while IFS= read -r node
do
    echo -e "Attempting to install npm package: ${GREEN}$node${NC}"
    if ! npm install -g "$node"; then
        echo -e "${RED}Error: Failed to install npm package: $node${NC}" >&2
        echo "Continuing to next package..."
    else
        echo -e "${GREEN}Successfully installed npm package: $node${NC}"
    fi
done < "$NODE_LIST"

# Revert permissions of node_modules directory
sudo chmod a-w /usr/lib/node_modules