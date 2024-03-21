#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# File containing the list of npm packages to install
NODE_LIST="$(dirname "$0")/../src/nodes.txt"

# Check if NODE_LIST file exists
if [ ! -f "$NODE_LIST" ]; then
    echo -e "${RED}Error: Node list file does not exist: $NODE_LIST${NC}" >&2
    exit 1
fi

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
