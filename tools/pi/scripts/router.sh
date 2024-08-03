!/usr/bin/bash
# source $(t3x -T)

#think this may be needed..
router_ip = "10.20.24.1"


disable_route() {}

enable_route() {}

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
# - adjust nft tables for enable/disable router..?
# - check for table changes
