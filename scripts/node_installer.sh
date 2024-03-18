#!/usr/bin/env bash

# File containing the list of packages to install
NODE_LIST="${0%/*}/src/nodes.txt"

while IFS= read -r node
do
    # Install each package listed in the packages.txt file
    sudo apt install -y "$node"
done < "$NODE_LIST"
