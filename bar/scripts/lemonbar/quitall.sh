#!/bin/sh
killall lemonbar
killall sleep
#pkill -9 -f /home/dada/scripts/lemonbar/workspaces.sh
#pkill -9 -f /home/dada/scripts/lemonbar/acpi.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/time.sh 
#pkill -9 -f /home/dada/scripts/lemonbar/app.sh 
pkill -9 -f /home/dada/scripts/lemonbar/bar.sh
pkill -9 -f /home/dada/scripts/lemonbar/bar_hybrid.sh
bspc quit

