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
 pamixer --list-sinks | grep "AirPods" && \
	sink=$( pamixer --list-sinks | grep AirPods | awk '{print $1}' ) ||\
	sink=$( pamixer --list-sinks | grep "WH-1000XM4" | awk '{print $1}' ) ||\
	sink=$( pamixer --list-sinks | sed -n 2p | awk '{print $1}' )
STEP=5

updatebars(){
	echo vol > /tmp/xmonad/cmd_xmonad &
}
voldowncmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume dec 5
#else

	#pactl set-sink-volume $sink -5%
	pamixer --sink $sink -d $STEP
#fi
}
volupcmd(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume inc 5
#else
	vol=$(pamixer --sink $sink --get-volume)
	vol=$(expr "$vol" + $STEP)
	if [ $vol -lt 100 ]; then
		pamixer --sink $sink -i $STEP
	elif [ $vol -eq 100 ]; then
		pamixer --sink $sink --set-volume 100
	elif [ $vol -gt 100 ];then
		echo ""
	fi
#fi
}
voltoggle(){
#if pgrep -x pulseaudio >/dev/null;then
	#pulseaudio_volume toggle
#else
	pamixer --sink $sink -t
#fi
}
Vol() {
	echo -e "Volume"
	(
	#if pgrep -x pulseaudio >/dev/null;then
	#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
#else
	#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}' | sed 's/%//g' | tac | head -1
	pamixer --sink $sink --get-volume
	 #amixer sget Master | grep "Front Left:" | awk '{print $5}' | sed -e 's/\[//g' -e 's/\]//g' -e 's/%//g'
#fi
	) | gdbar -max 100 -min 0 -s '-'
}
case $1 in
	up) 
	volupcmd
	updatebars
	#kill -s USR1 --- $(cat /tmp/volaback.pid)
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c' ;;
	down)
	voldowncmd
	updatebars
	#kill -s USR1 --- $(cat /tmp/volaback.pid)
	Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c';;
	toggle)
	voltoggle
	updatebars
	#kill -s USR1 --- $(cat /tmp/volaback.pid)
	if [ -n $( amixer get Master | tail -1 | grep off) ]; then
		Vol | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	else
		echo -e "Volume\nMute" | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
	fi;;
esac

