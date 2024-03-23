#!/usr/bin/env bash

t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

yak "sanity check initiated"

source $T3X_SCRIPTS_DIR/pkg_installer.sh

figlet "T3X" | lolcat

echo -n "sanity check success"; sleep 1; echo " . . . we hope" | pv -qL 5 | lolcat
