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

#!/bin/sh
sink=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')

voldowncmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume dec 5
#else

	pactl set-sink-volume $sink -5%
#fi
}
volupcmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume inc 5
#else
	vol=$( pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}' | sed 's/%//g' | tac | head -1 )
	if [ $vol -lt 100 ]; then
	pactl set-sink-volume $sink +5%
	fi
#fi
}
voltoggle(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume toggle
#else
	pactl set-sink-mute $sink toggle
#fi
}
Vol() {
	echo -e "Volume"
	(
	#if pgrep -x pulseaudio >/dev/null;then
	#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
#else
	pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}' | sed 's/%//g' | tac | head -1
	 #amixer sget Master | grep "Front Left:" | awk '{print $5}' | sed -e 's/\[//g' -e 's/\]//g' -e 's/%//g'
#fi
	) | gdbar -max 100 -min 0 -s '-'
}
case $1 in
	up) 
	volupcmd
	kill -s USR1 --- $(cat /tmp/volaback.pid)
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c' ;;
	down)
	voldowncmd
	kill -s USR1 --- $(cat /tmp/volaback.pid)
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c';;
	toggle)
	voltoggle
	kill -s USR1 --- $(cat /tmp/volaback.pid)
	if [ -n $( amixer get Master | tail -1 | grep off) ]; then
		Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	else
		echo -e "Volume\nMute" | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	fi;;
esac
