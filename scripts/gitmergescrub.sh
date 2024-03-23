#!/usr/bin/bash

function slow_lol() {
  msg="$1"
  msg_len=${#msg}
  twidth=$(tput cols)

  padding=$(( (twidth - msg_len ) / 2 ))
  printf "%*s" $padding ""
  echo "$msg" | pv -qL 22 | lolcat -S 33  -F 0.001
}

clear
figlet -w $(tput cols) -c "[ T3X : git ]" | lolcat -S 33 -a -d 2
slow_lol "Scrubbing bubble helper for merged git branches"
printf "\n\n\n"
sleep 1
slow_lol "."

if ! git rev-parse --git-dir > /dev/null 2>&1; then
  slow_lol "Error: Current folder is not a git repo"
  exit 1
fi

CURRENT=$(git branch --show-current)
if [ ! "$CURRENT" == "main" ]; then
  slow_lol "Error: Not on main branch"
  if [ "$1" == "-f" ]; then 
    slow_lol ".... but you said -f ... let us keep going"
  else
    exit 1
  fi
fi

# fetch to udpate information on remote
git fetch

# check if current branch is up to date with remote counterpart
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ $LOCAL = $REMOTE ]; then
  slow_lol "Good: Up to date with the remote branch"
elif [ $LOCAL = $BASE ]; then
  slow_lol "Warning: Local branchis behind the remote branch. Pull latest"
  exit 1
elif [ $REMOTE = $BASE ]; then
  echo "Local branch has diverged from the remote branch"
  exit 1
fi

for branch in $(git branch --merged @{u} | grep -v "^\*" | grep -v main); do
  slow_lol "Branch '$branch' is merged into the remote tracking branch and can be deleted"
  sleep 1
  output=$(git branch -d $branch)
  if [ $? -eq 0 ]; then
    slow_lol "$branch deleted"
  else
    slow_lol "Error: Failure in deleting $branch"
    slow_lol "$output"
    exit 1
  fi
  sleep 0.5
done 
printf "\n\n\n"
slow_lol "######## DONE ########"
sleep 0.5
printf "\n\n\n"
