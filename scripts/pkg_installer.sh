#!/usr/bin/env bash

# ANSI color codes
RED='\033[0;31m'   # Red
GREEN='\033[0;32m' # Green
NC='\033[0m'       # No Color

# File containing the list of packages to install
PACKAGE_LIST="$(dirname "$0")/../lib/packages.txt"

# Update package list to ensure packages are from the latest repository
echo -e "${GREEN} updating apt package database${NC}"
if ! sudo apt update; then
    echo -e "${RED}Error: Failed to update package lists.${NC}"
    exit 1
else
    echo -e "${GREEN}Package lists updated successfully.${NC}"
fi

# Loop through the packages.txt file
while IFS= read -r package
do
  if dpkg -s "$package" > /dev/null 2>&1 ; then
    echo "skipping $package ... already installed"
  else
    echo "missing: $package - installing"
    if ! sudo apt install -y "$package"; then
        echo -e "${RED}Error: Failed to install package: $package${NC}"
        echo "Continuing to next package..."
    else
        echo -e "${GREEN}Successfully installed package: $package${NC}"
    fi
  fi
done < "$PACKAGE_LIST"
