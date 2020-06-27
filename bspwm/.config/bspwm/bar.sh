#!/bin/sh
#script that kills all running bar scripts & bars and reexecutes them
killall lemonbar 
killall sleep
BG="#222222"
FONT="Iosevka Nerd Font:size=7"
pkill -f /home/dada/scripts/lemonbar/workspaces.sh 
pkill -f /home/dada/scripts/lemonbar/acpi.sh 
pkill -f /home/dada/scripts/lemonbar/time.sh 
pkill -f /home/dada/scripts/lemonbar/app.sh 
pkill -f /home/dada/scripts/lemonbar/mpd.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/workspaces.py 
#pkill -9 -f /home/dada/scripts/lemonbar/acpi.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/time.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/app.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/mpd.sh 
#echo " " | lemonbar -p  -B $BG -g x25 &
/home/dada/scripts/lemonbar/workspaces.sh | lemonbar -f $FONT -g 300x20+20+2 -B $BG -u 2 &
/home/dada/scripts/lemonbar/acpi.sh	  | lemonbar -f $FONT -g 50x20+1780+2 -B $BG&
/home/dada/scripts/lemonbar/time.sh	  | lemonbar -f $FONT -g 70x20+1830+2 -B $BG&
/home/dada/scripts/lemonbar/app.sh 	  | lemonbar -f $FONT -g 100x20+913+2 -B $BG&
/home/dada/scripts/lemonbar/mpd.sh 	  | lemonbar -f "Iosevka Nerd Font:size=12" -g 220x20+1540+2 -B $BG| sh &
#/home/dada/scripts/dzen/startmenu.sh | dzen2 -p -fn "Iosevka:size=12" -l '6' -m -tw 20 -w 100 -bg $BG -fg "#4D688A" &
