#!/usr/bin/env bash

# File containing the list of packages to install please
PACKAGE_LIST="$(dirname "$0")/../src/packages.txt"

# Update package list to ensure packages are from the latest repository
if ! apt update; then
    echo "Error: Failed to update package lists." >&2
    exit 1
else
    echo "Package lists updated successfully."
fi

# Loop through the packages.txt file
while IFS= read -r package
do
    if ! sudo apt install -y "$package"; then
        echo "Error: Failed to install package: $package" >&2
        echo "Continuing to next package..."
    else
        echo "Successfully installed package: $package"
    fi
done < "$PACKAGE_LIST"

