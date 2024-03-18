#!/usr/bin/env bash

t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

#bypass t3ize - to be removed when t3ize is fixed
helpers_sh="${0%/*}/../lib/helpers.sh"
source "$helpers_sh"

yak "sanity check initiated"
apt_install "figlet toilet cowsay fortune lolcat"
apt_install "jq curl git vim tmux htop"
apt_install "pv"
figlet "T3X" | lolcat

echo -n "sanity check success"; sleep 1; echo " . . . we hope" | pv -qL 5 | lolcat
