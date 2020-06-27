
#!/bin/sh
#A few arguments for lemonbar
BG="#dd2E3440"
#BG="#2E3440"
FONT="Iosevka Nerd Font:size=13"
HEIGHT=70
AppWidth=100
WSWidth=290
BatWidth=70
TimeWidth=80
MPDWidth=220
WsPos=0 
ModDist=10

bspc config top_padding 40

# find dimensions of monitor
WIDTH=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $2}' ) 
#HEIGHT=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $3}' ) 

#Calculate position of modules.
APPPOS=$(expr "$WIDTH" / 2 - $AppWidth / 2 )
TimePos=$(expr "$WIDTH" - $ModDist - $TimeWidth) 
BatPos=$(expr "$TimePos" - $BatWidth - $ModDist) 
MPDPos=$(expr "$BatPos" - $MPDWidth - $ModDist) 


#Battery module, show percentage and change color if charging.
Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	battery_status="$(acpi -b | awk -F '[[:space:]]+|,' '{ print $3 }')"
	case "$battery_status" in
		'Charging')
			echo " %{F#EA7866}$STATE  " ;;
			#echo "%{B#000433} %{F#EA7866}$STATE  " ;;
		'Discharging')
			echo " %{F#CE6864}$STATE  " ;;
			#echo "%{B#000433} %{F#CE6864}$STATE  " ;;
		'Full') 
			echo " %{F#B5BD68}$STATE  " 
			#echo "%{B#000433} %{F#00FF00}$STATE  " 
	esac
}

#Show currently open app, make a few substitutions for commonly used apps.
getApp() {
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  if pgrep -x bspwm; then
  case $app in
	  st|xst|urxvt) echo  "%{c}>_";;
	  qutebrowser) echo  "%{c}qb";;
	  soffice\.bin) echo  "%{c}LibreOffice";;
	  #qutebrowser) echo  "💿";;
	  "") echo  "%{c} desktop";;
	  *) echo  "%{c}$app";;
 esac
  fi
}

#Show currently playing song in mpd as well as its state.

setsong() {
current=$(mpc | grep -v "volume\|playing\|paused" | sed 's/\.opus//'| sed 's/\.m4a//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^DiverseSystem\///' )
echo  "$current"
}
setstate() { 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
echo  "%{A:mpc toggle:}$state%{A}"
}
#Show time
Time() { 
TIME=$( date "+%H:%M" )
#HOUR=$( date "+%H") 
#echo -n "$DATETIME"
#case $HOUR in
	#1|13)  echo -n "%{F#ffffff}🕐 $TIME";;
	#2|14)  echo -n "%{F#ffffff}🕑 $TIME";;
	#3|15)  echo -n "%{F#ffffff}🕒 $TIME";;
	#4|16)  echo -n "%{F#ffffff}🕓 $TIME";;
	#5|17)  echo -n "%{F#ffffff}🕕 $TIME";;
	#6|18)  echo -n "%{F#ffffff}🕕 $TIME";;
	#7|19)  echo -n "%{F#ffffff}🕖 $TIME";;
	#8|20)  echo -n "%{F#ffffff}🕗 $TIME";;
	#9|21)  echo -n "%{F#ffffff}🕘 $TIME";;
	#10|22) echo -n "%{F#ffffff}🕙 $TIME";;
	#11|23) echo -n "%{F#ffffff}🕚 $TIME";;
	#0)     echo -n "%{F#ffffff}🕛 $TIME";;
#esac
echo "$TIME"
}


#Show current worskpace in bspwm
showws() { 
echo "$1" | sed -e 's/:/\ /g' -e 's/WMeDP1//g' -e 's/LT//g' -e 's/TT//g' -e 's/G//g'  -e 's/O/%{U#A54242}%{F#A54242}%{!u}/' -e 's/\ F/\ %{U#A54242}%{F#D9CBBE}%{!u}/' -e 's/\ o/%{-u}\ %{-u}%{F#A54242}/g' -e 's/\ u/%{-u}\ %{-u}%{F#87A7B2}/g' -e 's/\ f/%{-u}\ %{-u}%{F#D9CBBE}/g' 
}
#First print a grey bar containing nothing, we then print modules on top of it.
#echo " " | lemonbar -p -B "$BG" -g x$HEIGHT &
#BSPWM worskpace detection
while true; do
	state=$(bspc subscribe -c 1 report)
	showws "$state"
	bspc subscribe -c 2 report > /tmp/tests
done | lemonbar -a 9 -f "$FONT" -g $WSWidth\x30+$WsPos+2 -B $BG -u 2 &

#Battery level detection
while true; do
	echo "%{l}%{F#FECC6D} ⚡$(Battery)"
	#echo "%{B#000433}%{l}%{F#FECC6D}⚡$(Battery)"
	sleep 1m;
done | lemonbar -f "$FONT" -g $BatWidth\x34+$BatPos -B $BG&

#current app detection
while true; do
if pgrep -x bspwm; then
echo " %{c}%{F#D9CBBE}$(getApp) "
bspc subscribe -c 2 report > /dev/null
fi
done | lemonbar -f "$FONT" -g $AppWidth\x34+$APPPOS -B $BG&

#MPD detection
#while true; do
	#if pgrep -x mpd > /dev/null
	#then
		#echo "%{F#ffffff}%{A:mpc prev:} %{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}%{A}%{F#ffffff}  $(setsong)"
		#mpc idle >/dev/null
	#else
		#echo ""
		#sleep 1m
	#fi
##echo "%{F#ffffff}%{A:mpc prev:}⏪%{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}⏩%{A}%{F#ffffff}$(setsong)"
#done | lemonbar -f "Iosevka Nerd Font:size=12" -g $MPDWidth\x20+$MPDPos+4 -B $BG| sh &

#Time detection
while true; do
	echo "%{c}%{F#ffffff}$(Time) "
	#echo " %{B#000433} $(Date) "
	sleep 1m;
done | lemonbar -f "$FONT" -g "$TimeWidth"\x34+$TimePos -B "$BG"&


