!/usr/bin/bash
#source $(t3x -T)

status_Router() {}

status_AP() {}

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
