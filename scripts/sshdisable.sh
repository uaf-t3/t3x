#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

#stop ssh and disable s
echo "attempting to disable ssh"
sudo systemctl stop ssh.service
sudo systemctl disable ssh.service