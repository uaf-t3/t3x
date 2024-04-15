#!/usr/bin/bash
# Dayne Broderson 2024
# Installer script for the t3x that can be run a few ways:
## ./installer.sh
## T3X_REPO_URL="git@github.com:uaf-t3/t3x" ./installer.sh 
## FIXME: curl https://github.com/uaf-t3/t3x/ | bash -c 

DEFAULT_T3X_REPO_URL="https://github.com/uaf-t3/t3x"
DEFAULT_TARGET_HOME="$HOME"
DEFAULT_TARGET_BIN="$HOME/.local/bin"

TARGET_HOME=${TARGET_HOME:=$DEFAULT_TARGET_HOME}
T3X_REPO_URL=${T3X_REPO_URL:=$DEFAULT_T3X_REPO_URL}
TARGET_BIN=${TARGET_BIN:=$DEFAULT_TARGET_BIN}

echo TARGET_HOME  = $TARGET_HOME
echo T3X_REPO_URL = $T3X_REPO_URL
echo TARGET_BIN   = $TARGET_BIN

sleep 1

if [ ! -d $TARGET_BIN ]; then
  echo "Error: TARGET_BIN does not exist: $TARGET_BIN"
  exit 1
fi

if $(echo $PATH | grep $TARGET_BIN > /dev/null); then
  echo "Success: \$PATH includes \$TARGET_BIN=$TARGET_BIN"
else
  echo "Warning: \$PATH does NOT includes \$TARGET_BIN=$TARGET_BIN"
  sleep 2
  echo "recommend fixing this"
  sleep 3
fi

if ! command -v git > /dev/null; then
  echo "missing command: git"
  echo "fix: sudo apt install git"
  exit 1
fi

if [ ! -d $TARGET_HOME ]; then
  echo "making $TARGET_HOME for t3x"
  mkdir -p $TARGET_HOME
fi

cd $TARGET_HOME
if [ ! -d t3x ]; then
  git clone $T3X_REPO_URL
  if [ $? -eq 0 ]; then
    echo "clone success"
  else
    echo "unable to: git clone https://github.com/uaf-t3/t3x"
    exit 1
  fi
fi

cd t3x
for app in bin/*; do
  if [ ! -f $TARGET_BIN/$app ]; then
    echo "linking $app into $TARGET_BIN"
    cp -l $app $TARGET_BIN/
    sleep 0.5
  else
    echo "Warning: $(basename $app) exists in $TARGET_BIN.  skipping link"
    sleep 0.5
  fi
done
