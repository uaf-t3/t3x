#!/usr/bin/bash

if [ ! -d ~/rtl433_to_mqtt ]; then
cd
git clone https://github.com/dayne/rtl433_to_mqtt
else
echo "rtl433_to_mqtt already exists - skipping install."
fi

if [ ! -f /usr/bin/mosquitto_pub ]; then
sudo apt install mosquitto-clients

if [ $? -eq 0 ]; then
echo "mosquitto-clients installed"
else
echo "Failed to install mosquitto-clients."
fi

else
echo "mosquitto-clients already exists - skipping install."
fi


cd ~/rtl433_to_mqtt

sudo ./setup.sh

if [ ! $? -eq 0 ]; then
echo "Setup failed."
fi
