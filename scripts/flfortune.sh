#!/usr/bin/bash
# T3XHELP: Silly fortune through lolcat looper
source $(t3x -T)

require_command fortune
require_command lolcat
require_command pv

while(true); do
    clear
    echo -e "\n\n\n"
    fortune | pv -qL $[20+(-2 + RANDOM%5)] | lolcat 
    echo -e "\n\n\n"
    sleep 30 
done
