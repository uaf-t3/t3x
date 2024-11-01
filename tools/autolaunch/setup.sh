#!/usr/bin/bash
# 
#./files
#├── autolaunch            -> $HOME/Documents/autolaunch
#│   └── lxsession
#│       └── autolaunch
#├── lxsession.config      -> $HOME/.config/lxsession/LXDE-pi/autostart
#└── lxsession.config.info
#
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)

LXSESSION_DIR=$HOME/.config/lxsession/LXDE-pi
LXSESSION_FILE_SOURCE="${SCRIPT_DIR}/files/lxsession.config"
LXSESSION_FILE_TARGET="${HOME}/.config/lxsession/LXDE-pi/autostart"

AUTODIR_DIR="${HOME}/Documents"
AUTODIR_SOURCE="${SCRIPT_DIR}/files/autolaunch"
AUTODIR_TARGET="${AUTODIR_DIR}/"

if [ ! -d "$LXSESSION_DIR" ]; then
	echo "Creating config folder: $LXSESSION_DIR"
	mkdir -p $LXSESSION_DIR
else
	echo "Skipping config folder: $LXSESSION_DIR exists"
fi

if [ -f "$LXSESSION_FILE_TARGET" ]; then
	echo "Skipping create LXDE autostart .. file exists: $LXSESSION_FILE_TARGET"
else
	echo "Copying in the new LXDE autostart: $LXESSION_FILE_TARGET"
	cp -v "$LXSESSION_FILE_SOURCE" "$LXSESSION_FILE_TARGET"
fi

if [ ! -d "$AUTODIR_DIR" ]; then
	echo "Creating $AUTODIR_DIR"
	mkdir -p "$AUTODIR_DIR"
fi

echo "Copying over autolaunch (no clobber) into $HOME/Documents"
cp -rvn "$AUTODIR_SOURCE" "$AUTODIR_TARGET"
