#!/usr/bin/bash
source $(t3x -T)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)

#figlet "LOCKDOWN" | lolcat
#sleep 1

disable_ssh() {
  t3x pi ssh-disable # raspi-config style
}

disable_vnc() {
  # raspi-config style
}

enable_firewall() {
  # install ufw
  # turn it on
  # lock down everything
}

bad_password_check() {
  # t3x pi
}

nodered_lockdown() {
  # TODO: just call: t3x nodered lockdown
}


case $1 in
  check)
    ;;
  full) 
    ;;
  ssh)
    disable_ssh
    ;;
  vnc)
    disable_vnc
    ;;
  *)
    echo "pickles"
    ;;
esac
