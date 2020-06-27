#!/bin/sh
Killbar() { 
	pkill lemonbar
	pkill dzen
	killall xtitle
	pkill -f /home/dada/scripts/lemonbar/bar.sh
	bspc config top_padding 0
}
Togglebar() { 
bspc config top_padding 20
exec /home/dada/scripts/lemonbar/bar.sh
}
if pgrep -x lemonbar > /dev/null; then
	Killbar
else
	Togglebar
fi
