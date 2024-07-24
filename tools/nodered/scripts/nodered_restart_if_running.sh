#!/usr/bin/env bash

if pgrep -x "node-red" >/dev/null; then
    echo "Outdated Node-RED is still running. Attempting to restart..."
    node-red-restart
    echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
  else
    echo "Node-RED configuration updated. It will be applied when Node-RED is started."
  fi