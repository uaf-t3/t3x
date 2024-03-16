#!/usr/bin/env bash

# File containing the list of packages to install
PACKAGE_LIST='packages.txt'

# Update package list to ensure packages are from the latest repository
apt update

# Loop through the packages.txt file
while IFS= read -r package
do
    # Install each package listed in the packages.txt file
    apt install -y "$package"
done < "$PACKAGE_LIST"