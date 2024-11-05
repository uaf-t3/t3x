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

if [ ! -f "${AUTOSTART_DIR}/autolaunch.desktop" ]; then
	echo "Installing autolaunch.desktop in $AUTOSTART_DIR"
	cp $SCRIPT_DIR/files/autolaunch.desktop $AUTOSTART_DIR
fi

if [ ! -d "$AUTODIR_DIR" ]; then
	echo "Creating $AUTODIR_DIR"
	mkdir -p "$AUTODIR_DIR"
fi

echo "Copying over autolaunch (no clobber) into $HOME/Documents"
cp -rvn "$AUTODIR_SOURCE" "$AUTODIR_TARGET"

### the above should work fine on latest raspberry pi OS
### the below is for legacy systems on X11

if pgrep labwc > /dev/null; then 
  echo "Detected labwc running .. skipping autolaunch.lxsession setup"
else
  echo "labwc not detected .. assuming legacy setup is needed for lxsession"
  $SCRIPT_DIR/files/autolaunch.lxsession
fi
