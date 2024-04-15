#!/usr/bin/bash

# SCRIPT_DIR=
cd ~/t3x
if [ -f .git/config ]; then
  echo "T3X is a git repo .. using to update"
else
  echo "T3X is not a git repo -- a manual update will be needed"
  exit 1
fi

CURRENT=$(git branch --show-current)
if [ ! "$CURRENT" == "main" ]; then
  if [ "$1" == "-f" ]; then 
    #slow_lol "Warning: not on main branch .... but you said -f ... let us keep going"
    echo "Warning: not on main branch .... but you said -f ... let us keep going"
  else
    #slow_lol "Error: Not on main branch ... overide this with -f"
    echo "Error: Not on main branch ... overide this with -f"
    exit 1
  fi
fi

# fetch to udpate information on remote
git pull
