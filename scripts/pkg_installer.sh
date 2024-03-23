#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# File containing the list of packages to install
PACKAGE_LIST="$(dirname "$0")/../lib/packages.txt"

# Update package list to ensure packages are from the latest repository
if ! sudo apt update; then
    echo -e "${RED}Error: Failed to update package lists.${NC}" >&2
    exit 1
else
    echo -e "${GREEN}Package lists updated successfully.${NC}"
fi

# Loop through the packages.txt file
while IFS= read -r package
do
    if ! sudo apt install -y "$package"; then
        echo -e "${RED}Error: Failed to install package: $package${NC}" >&2
        echo "Continuing to next package..."
    else
        echo -e "${GREEN}Successfully installed package: $package${NC}"
    fi
done < "$PACKAGE_LIST"
