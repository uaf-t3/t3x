#!/usr/bin/env bash
# just fun

source $(t3x -T)

require_command "pv"
require_command "lolcat"

clear
sleep 0.5
echo " ##########################################" | lolcat &&
echo " # !!! Amidst a labyrinth of code ...     #  
 #  minds burdened by the load ..         # 
 #         simplicity a forgotten art ..  #
 # the wizards wander                     #
 #                    smiling             #
 #  trapped in a T3X dream  !!!           #" \
 | pv -qL $[20+(-2 + RANDOM%5)] | lolcat &&
echo " ##########################################  " | lolcat
sleep 1
