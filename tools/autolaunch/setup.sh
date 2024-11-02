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

AUTOSTART_DIR=$HOME/.config/autostart/

AUTODIR_DIR="${HOME}/Documents"
AUTODIR_SOURCE="${SCRIPT_DIR}/files/autolaunch"
AUTODIR_TARGET="${AUTODIR_DIR}/"


if [ ! -d "$AUTOSTART_DIR" ]; then
	echo "Creating $AUTOSTART_DIR"
	mkdir -p "$AUTOSTART_DIR"
fi

if [ ! -f "${AUTOSTART_DIR}/autostart.desktop" ]; then
	echo "Installing autostart.desktop in $AUTOSTART_DIR"
	cp $SCRIPT_DIR/files/autostart.desktop $AUTOSTART_DIR
fi

if [ ! -d "$AUTODIR_DIR" ]; then
	echo "Creating $AUTODIR_DIR"
	mkdir -p "$AUTODIR_DIR"
fi

echo "Copying over autolaunch (no clobber) into $HOME/Documents"
cp -rvn "$AUTODIR_SOURCE" "$AUTODIR_TARGET"
