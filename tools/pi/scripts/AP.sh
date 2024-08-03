!/usr/bin/bash
#source $(t3x -T)

#var set to AP SSID
AP="RaspAP"

AP_up() {}

AP_down() {}


case "$1" in
	up)
		# pull AP up
		;;
	down)
		# pull AP down
		;;
	*)
		# display command usage?
		exit 1
		;;
esac
