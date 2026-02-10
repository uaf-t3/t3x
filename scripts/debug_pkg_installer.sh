#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# File containing the list of packages to remove
PACKAGE_LIST="$(dirname "$0")/../src/packages.txt"

# Loop through the packages.txt file
while IFS= read -r package
do
    if ! sudo apt purge -y "$package"; then
        echo -e "${RED}Error: Failed to purge package: $package${NC}" >&2
        echo "Continuing to next package..."
    else
        echo -e "${GREEN}Successfully purged package: $package${NC}"
    fi
done < "$PACKAGE_LIST"
