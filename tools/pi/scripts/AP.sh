#!/usr/bin/bash
source $(t3x -T)

#var set to AP SSID
AP="RaspAP"

connection_status=$(nmcli -t -f NAME connection show --active | grep "^$AP")


AP_up() {
	nmcli connection up "$AP"
	echo "Access Point '$AP' has been turned on"
}

AP_down() {
	nmcli connection down "$AP"
	echo "Access Point '$AP' has been turned off"
}

#check if AP has ever been connected to this dev
first_con() {
	nmcli dev wifi connection "$AP" password "raspberry"

	if [$? -eq 0]; then
		echo "Connection to $AP success"
	else 
		echo "Failed to connect to $AP"
	fi
}

connection_check() {
	if [ -f "/etc/wifi_connection" ]; then
		if grep -q "$AP" "/etc/wifi-connection"; then
			exit 0
		else
			first_con
		fi
	fi
}

connection_check

case "$1" in
	up)
		# pull AP up
		AP_up
		;;
	down)
		# pull AP down
		AP_down
		;;
	*)
		# display command usage?
		exit 1
		;;
esac
