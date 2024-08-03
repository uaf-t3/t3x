!/usr/bin/bash
#source $(t3x -T)

status_Router() {}

status_AP() {
	interface = "wlan0" #this may change though....
	AP="RaspAP"
	
	echo "Status: "
	if nmcli device show "$interface" &> /dev/null; then
		
		wifi_status=$(nmcli -t -f GENERAL.STATE device show "$interface" | awk -F: '{print $2}')
		echo "$wifi_status"

		if echo "$wifi_status" | grep -q "disconnected" ; then
			echo "Raspberry AP is : DISCONNECTED" 
		else
			echo "Raspberry AP is : CONNECTED"
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
# - fill the functions
# - compare on and off for each function
# - print usage?
# - test on new pi
# - test t3x compatability..
