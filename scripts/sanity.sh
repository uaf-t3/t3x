#!/usr/bin/env bash

t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

yak "sanity check initiated"
sudo apt install "figlet toilet cowsay fortune lolcat"
sudo apt install "jq curl git vim tmux htop"
sudo apt install "pv"
figlet "T3X" | lolcat

echo -n "sanity check success"; sleep 1; echo " . . . we hope" | pv -qL 5 | lolcat
