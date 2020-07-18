#!/bin/sh

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
cur=$(cat /sys/class/backlight/intel_backlight/brightness)
int=3000

WIDTH=300
HEIGHT=150
POSX=810
POSY=800
FONT="Iosevka"
FG=
TIMEOUT=1
Back() {
	echo -e "Backlight"
	(
	    max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
	#if pgrep -x pulseaudio >/dev/null;then
	#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
#else
	   cat /sys/class/backlight/intel_backlight/brightness | tr -d '\n' 
	 #amixer sget Master | grep "Front Left:" | awk '{print $5}' | sed -e 's/\[//g' -e 's/\]//g' -e 's/%//g'
#f
	) | gdbar -max $max -min 0 -s '-' 
	    	    
}
backlight_up(){
    new_back=$(expr "$cur" + $int)
    if [ $new_back -lt 60000 ]; then
    echo $new_back | doas tee /sys/class/backlight/intel_backlight/brightness >/dev/null
    else
    echo 60000 | doas tee /sys/class/backlight/intel_backlight/brightness >/dev/null
    fi
    cat /sys/class/backlight/intel_backlight/brightness
}

backlight_down(){
    new_back=$(expr "$cur" - $int)
    echo $new_back | doas tee /sys/class/backlight/intel_backlight/brightness >/dev/null
    cat /sys/class/backlight/intel_backlight/brightness
}
case $1 in
    'up') kill -s USR1 --- $(cat /tmp/volaback.pid)
	backlight_up && Back | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
;;
    'down')  kill -s USR1 --- $(cat /tmp/volaback.pid)
backlight_down && Back | dzen2 -p -h 40 -tw $WIDTH -w $WIDTH -x $POSX -y $POSY   -p $TIMEOUT  -l '1' -fn $FONT -e 'onstart=uncollapse' -sa 'c'
;;
esac
