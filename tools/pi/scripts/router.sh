#!/usr/bin/bash
source $(t3x -T)

#think this may be needed..
router_ip = "10.20.24.1"

disable_route() {
	echo "disabling traffic to Router: $router_ip"
	sudo nft add table inet filter
	sudo nft add rule inet filter output drop 
	echo "traffic to router is: DISABLED"
}

enable_route() {
	echo "Enabling traffic to router: $router_ip"
	sudo nft flush table inet filter
	echo "Traffic to router is now: ENABLED"
}


case "$1" in
	enable)
		enable_route
		;;
	disable)
		disable_route
		;;
	*)
		exit 1
		;;
esac

#TODO
# - check for table changes?
