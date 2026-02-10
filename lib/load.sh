#!/usr/bin/env bash
# Loads all lib scripts in consistent order

LIB_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )

source "$LIB_DIR/helpers.sh"
source "$LIB_DIR/silly.sh"
