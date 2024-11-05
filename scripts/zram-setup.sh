#!/usr/bin/bash
# https://github.com/novaspirit/rpi_zram
# sudo wget -q https://git.io/vM1kx -O /tmp/rpizram && bash /tmp/rpizram

DOWNLOAD_URL="https://raw.githubusercontent.com/novaspirit/rpi_zram/master/zram.sh"
BIN_FILE=/usr/local/bin/zram.sh

if ! command -v wget > /dev/null; then
  echo "Error: missing wget .. fix: sudo apt install wget"
  exit 1
fi

if [ ! -f "$BIN_FILE" ]; then
  echo "Action: wget $BIN_FILE from $DOWNLOAD_URL"
  sudo wget -O "$BIN_FILE" "$DOWNLOAD_URL"
  if [ $? -eq 0 ]; then
    echo "Success: Downloaded $BIN_FILE"
  else
    echo "Error: Unable to download zramh.sh $DOWNLOAD_URL"
    exit 1
  fi
else
  echo "Skipping download ...  $BIN_FILE exists already"
fi

if test -x "$BIN_FILE"; then
  echo "Success: $BIN_FILE is executable"
else
  echo "Action: Setting +x on $BIN_FILE"
  sudo chmod +x "$BIN_FILE"
fi

if [ ! -f /etc/rc.local ]; then
  echo "Error: /etc/rc.local doesn't exist ... bonkers sauce"
  exit 1
fi

if grep "$BIN_FILE" /etc/rc.local > /dev/null; then
  echo "Skipping zram setup in rc.local -- already configured"
else
  #sudo sh -c "echo '$BIN_FILE &' >> /etc/rc.local"
  sudo sed -i '/exit 0/i $BIN_FILE &' /etc/rc.local
  if [ $? -eq 0 ] ; then
    echo "Success: rc.local will call $BIN_FILE now"
    echo "Reboot is needed now"
  else
    echo "Failed to setup $BIN_FILE in /etc/rc.local"
    echo "Fix it by manually doing the following steps"
    echo "1) Add the following line to /etc/rc.local"
    echo "   Warning: It needs to come before 'exit 0' (last line)"
    echo "$BIN_FILE &"
    echo "2) reboot and see if it worked"
  fi
fi
