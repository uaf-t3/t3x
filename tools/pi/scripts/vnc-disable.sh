#!/usr/bin/bash
source $(t3x -T)

if command -v vncserver-x11-serviced; then
  echo "Ensuring VNC server is stopped"
  sudo systemctl stop vncserver-x11-serviced.service || failed=true
  sudo systemctl disable vncserver-x11-serviced.service || failed=true
  if [[ $failed = "true" ]]; then
    echo -e "${RED}VNC server not fully stopped${NC}"
    exit 1
  else
    echo -e "${GREEN}VNC server disabled${NC}"
    exit 0
  fi
else
  echo "VNC not installed ... all good"
  exit 0
fi

