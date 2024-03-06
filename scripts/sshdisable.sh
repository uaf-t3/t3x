#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

#stop ssh and disable ssh on startup. Requires root privelege
echo "attempting to disable ssh"
systemctl stop ssh.service
systemctl disable ssh.service