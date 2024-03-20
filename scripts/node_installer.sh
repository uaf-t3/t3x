#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

# File containing the list of npm packages to install
NODE_LIST="${0%/*}/src/nodes.txt"

# Loop through the nodes.txt file
while IFS= read -r node
do
    # Install each npm package listed in the nodes.txt file
    # This installs packages globally; remove -g flag if local installation is desired
    npm install -g "$node"
done < "$NODE_LIST"