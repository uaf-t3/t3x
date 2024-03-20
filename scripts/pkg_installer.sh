#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"


# File containing the list of packages to install
PACKAGE_LIST="${0%/*}/src/packages.txt"

# Update package list to ensure packages are from the latest repository
apt update

# Loop through the packages.txt file
while IFS= read -r package
do
    # Install each package listed in the packages.txt file
    sudo apt install -y "$package"
done < "$PACKAGE_LIST"