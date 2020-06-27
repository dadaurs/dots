#!/bin/sh
#USED TO RAISE VOLUME AND UPDATE DWMBAR
WIDTH=300
HEIGHT=150
POSX=810
POSY=800
FONT="Iosevka"
FG=
TIMEOUT=1
VOLPERC=$( pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}')
voldowncmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume dec 5
#else
	amixer set Master 5%-
#fi
}
volupcmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume inc 5
#else
	amixer set Master 5%+
#fi
}
voltoggle(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume toggle
#else
	amixer set Master toggle
#fi
}
Vol() {
	echo -e "Volume"
	(
	#if pgrep -x pulseaudio >/dev/null;then
	#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
#else
	 amixer sget Master | grep "Front Left:" | awk '{print $5}' | sed -e 's/\[//g' -e 's/\]//g' -e 's/%//g'
#fi
	) | gdbar -max 100 -min 0 -s '-'
}
case $1 in
	up) 
	volupcmd
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c' ;;
	down)
	voldowncmd
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c';;
	toggle)
	voltoggle
	if [ -n $( amixer get Master | tail -1 | grep off) ]; then
		Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	else
		echo -e "Volume\nMute" | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	fi;;
esac
