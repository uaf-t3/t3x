!/usr/bin/bash
#source $(t3x -T)

#var set to AP SSID
AP="RaspAP"

AP_up() {
	nmcli connection up "$AP"
	echo "Access Point '$AP' has been turned on"
}

AP_down() {
	nmcli connection down "$AP"
	echo "Access Point '$AP' has been turned off"

}


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
