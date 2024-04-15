#!/usr/bin/bash
source $(t3x -T)

figlet "T 3 X   PI" | lolcat
echo "Update & upgrade packages"
sleep 1

#verify_internet_access
#apt_update
#apt_has_updates
#git_has_updates

sudo_run "apt update"
sudo_run "apt upgrade -y"
