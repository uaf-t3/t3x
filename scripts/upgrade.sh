#!/usr/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)
$SCRIPT_DIR/update.sh
$SCRIPT_DIR/sanity.t3x
