#!/usr/bin/bash
source $(t3x -T)

if command -v ufw &> /dev/null; then
  echo "Verified ufw (uncomplicated firewall) is available"
else
  echo "Missing ufw ... installing"
  apt_update
  apt_install ufw
fi

if [ -f $HOME/.t3x/nolockdown ]; then
  slow_lol "~/.t3x/nolockdown exists ... skipping enabling ufw"
  exit 0
fi

if ! sudo ufw status | grep -qw "active"; then
  echo "Activating ufw"
  sudo ufw enable
  sudo systemctl enable ufw
  sudo systemctl start ufw
else
  echo "Verified ufw firewall is active".
fi
