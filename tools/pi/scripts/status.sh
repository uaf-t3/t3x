#!/usr/bin/bash
source $(t3x -T)

require_command "lolcat"

status_Router() {
	if sudo nft list ruleset | grep -q "drop"; then
		echo "Router is currently:"
		echo " DISABLED" | lolcat
	else
		echo "Router is currently:"
		echo " ENABLED" | lolcat
	fi
}

status_AP() {
	interface = "wlan0" #this may change though....
	AP="RaspAP"
	
	echo "Status: "
	if nmcli device show "$interface" &> /dev/null; then
		
		wifi_status=$(nmcli -t -f GENERAL.STATE device show "$interface" | awk -F: '{print $2}')
		echo "$wifi_status"

		if echo "$wifi_status" | grep -q "disconnected" ; then
			echo "Raspberry AP is :"
			echo " DISCONNECTED" | lolcat 
		else
			echo "Raspberry AP is :"
			echo " CONNECTED" | lolcat
		fi
	else
		echo "Connection $interface does not exist"
	fi
}

#main
case "$1" in 
	router)
		status_Router
		;;
	ap)
		status_AP
		;;
	*)
		#usage?
		;;
esac

#TODO
# - build a help section?
# - additional QC?
