#!/usr/bin/env bash

t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

echo "sanity.sh"
boom "stop sanity check"
apt_install "figlet"
apt_install "toilet"
apt_install "cowsay"
apt_install "fortune"
apt_install "lolcat"
apt_install "jq"
apt_install "curl"
apt_install "git"
apt_install "vim"
apt_install "tmux"
apt_install "htop"