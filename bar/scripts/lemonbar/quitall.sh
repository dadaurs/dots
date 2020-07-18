#!/bin/sh
killall lemonbar
killall sleep
#pkill -9 -f $HOME/scripts/lemonbar/workspaces.sh
#pkill -9 -f $HOME/scripts/lemonbar/acpi.sh 
#pkill -9 -f $HOME/scripts/lemonbar/time.sh 
#pkill -9 -f $HOME/scripts/lemonbar/app.sh 
pkill -9 -f $HOME/scripts/lemonbar/bar.sh
pkill -9 -f $HOME/scripts/lemonbar/bar_hybrid.sh
killall clipmenud
bspc quit

