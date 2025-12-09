#!/usr/bin/bash
source $(t3x -T)

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
    if agree "Did you want to switch to the main branch? (git switch main)"; then
      run git switch main
      if [ $? -eq 0 ]; then
        echo "success: git switch main"
      else
        sleep 1
        run git status
        echo -e "${RED}failed: git switch main${NC}"
        echo "debug that error and try again"
        sleep 1
        exit 1
      fi
    else
      echo "Error: Not on main branch ... overide this with -f"
      exit 1
    fi
  fi
fi

# fetch to udpate information on remote
run git pull
