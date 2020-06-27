 #echo '%{B#777777}%{U#e5e8ec}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}%{B#e5e8ec}%{F#ff5a5e65}%{U#777777}%{+u}%{+o}  40°F, Mist  %{B-}%{F-}%{U-}%{-u}%{-o}%{B#777777}%{U#e5e8ec}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}' | lemonbar -p -u2 -B#00000000
##c6dc93
#!/bin/sh
#A few arguments for lemonbar
BG="#1D1F21"
BG2="#777777"
FONT="Iosevka Nerd Font:size=13"
HEIGHT=25
AppWidth=100
WSWidth=300
WSHeight=20
BatWidth=70
TimeWidth=75
MPDWidth=220
WsPos=20 
ModDist=10


# find dimensions of monitor
WIDTH=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $2}' ) 
#HEIGHT=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $3}' ) 

#Calculate position of modules.
APPPOS=$(expr "$WIDTH" / 2 - $AppWidth / 2 )
TimePos=$(expr "$WIDTH" - $ModDist - $TimeWidth) 
BatPos=$(expr "$TimePos" - $BatWidth - $ModDist) 
MPDPos=$(expr "$BatPos" - $MPDWidth - $ModDist) 


Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	battery_status="$(acpi -b | awk -F '[[:space:]]+|,' '{ print $3 }')"
	case "$battery_status" in
		'Charging')
			state="%{F#FECC6D}⚡ %{F#EA7866}$STATE" ;;
			#state="%{l}%{F#FECC6D}⚡%{F#EA7866}$STATE" ;;
			#echo "%{B#000433} %{F#EA7866}$STATE  " ;;
		'Discharging')
			state="%{F#FECC6D}⚡ %{F#CE6864}$STATE" ;;
			#state=" %{l}%{F#FECC6D}⚡%{F#CE6864}$STATE" ;;
		'Full') 
			state=" %{F#FECC6D}⚡ %{F#000000}$STATE " 
			#state=" %{l}%{F#FECC6D}⚡%{F#000000}$STATE " 
	esac
	pre="%{B#FFFFFF}%{U#00FF00}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}%{B#81A1C1}%{F#ff5a5e65}%{U#FFFFFF}%{+u}%{+o}"
 post="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#FFFFFF}%{U#81A1C1}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}"
 echo "$pre$state$post"
}

#Show currently open app, make a few substitutions for commonly used apps.
getApp() {
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  case $app in
	  st|xst|urxvt) name="%{c}>_";;
	  qutebrowser) name="%{c}qb";;
	  soffice\.bin) name= "%{c}LibreOffice";;
	  #qutebrowser) echo  "💿";;
	  "") name="%{c} desktop";;
	  *) name="%{c}$app";;
 esac
 #pre="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#777777}%{U#e5e8ec}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}"
pre="%{B#777778}%{U#e5e8ec}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}%{B#e5e8ec}%{F#ff5a5e65}%{U#777777}%{+u}%{+o}"
 post="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#777777}%{U#e5e8ec}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}"
 echo "$pre$name$post"
}

setsong() {
current=$(mpc -f "%title%" | sed 1q)
echo  "$current"
}
setstate() { 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
echo  "%{A:mpc toggle:}$state%{A}"
}
#Show time
Time() { 
TIME=$( date "+%H:%M" )
pre=" %{B#FFFFFF}%{U#00FF00}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}%{B#FFB347}%{F#ff5a5e65}%{U#FFFFFF}%{+u}%{+o}"
post="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#FFFFFF}%{U#FFB347}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u} "
 echo -e " $pre$TIME$post "
}


#Show current worskpace in bspwm
showws() { 
pre=" %{B#FFFFFF}%{U#00FF00}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u}%{B#FFB347}%{F#ff5a5e65}%{U#FFFFFF}%{+u}%{+o}"
post="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#FFFFFF}%{U#FFB347}%{B#000000}"
#post="%{B-}%{F-}%{U-}%{-u}%{-o}%{B#FFFFFF}%{U#FFB347}%{+o}%{+u}%{O1}%{B-}%{U-}%{-o}%{-u} "
	#-e 's/\ F/\ %{U#A54242}%{F#D9CBBE}%{!u}/g'\
	#-e "s/F/\ %{U#A54242}%{F#D9CBBE}%{!u}/g"\
echo "$1" | sed\
	-e "s/WMeDP1:/\ /g"\
	-e "s/:/\ /g"\
	-e 's/LT//g'\
	-e 's/TT//g'\
	-e 's/G//g'\
	-e "s/\ O/\ $pre%{U#A54242}%{F#A54242}%{!u}/g"\
	-e "s/\ o/$post\ $pre%{-u}%{-u}%{F#A54242}/g"\
	-e "s/\ u/\ $pre%{-u}%{F#87A7B2}/g"\
	-e "s/\ f/\ $pre%{-u}%{F#D9CBBE}/g" 
	#-e 's/\ f/%{-u}\ %{-u}%{F#D9CBBE}/g' 
#echo "$1" | sed -e 's/:/\ /g' -e 's/WMeDP1//g' -e 's/LT//g' -e 's/TT//g' -e 's/G//g'  -e 's/O/%{U#A54242}%{F#A54242}%{!u}/' -e 's/\ F/\ %{U#A54242}%{F#D9CBBE}%{!u}/' -e 's/\ o/%{-u}\ %{-u}%{F#A54242}/g' -e 's/\ u/%{-u}\ %{-u}%{F#87A7B2}/g' -e 's/\ f/%{-u}\ %{-u}%{F#D9CBBE}/g' 
}
#First print a grey bar containing nothing, we then print modules on top of it.
#echo " " | lemonbar -p -B "$BG" -g x$HEIGHT &
#BSPWM worskpace detection
while true; do
	state=$(bspc subscribe -c 1 report)
	showws "$state"
	bspc subscribe -c 2 report > /tmp/tests
done | lemonbar -a 9 -f "$FONT" -g $WSWidth\x20+$WsPos+2 -B $BG -u 2 &

#Battery level detection
while true; do
	echo "$(Battery)"
	sleep 1m;
done | lemonbar -f "$FONT" -g $BatWidth\x20+$BatPos+2 -B $BG&

#current app detection
while true; do
echo " $(getApp) "
#echo " %{c}%{F#D9CBBE}$(getApp) "
bspc subscribe -c 2 report > /dev/null
done | lemonbar -f "$FONT" -g 100x20+$APPPOS+2 -B $BG &

#MPD detection
while true; do
	if pgrep -x mpd > /dev/null
	then
		echo "%{F#ffffff}%{A:mpc prev:} %{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}%{A}%{F#ffffff}  $(setsong)"
		mpc idle >/dev/null
	else
		echo ""
		sleep 1m
	fi
done | lemonbar -f "Iosevka Nerd Font:size=12" -g $MPDWidth\x20+$MPDPos+2 -B $BG| sh &

#Time detection
while true; do
	echo "%{c}%{F#ffffff}$(Time) "
	#echo " %{B#000433} $(Date) "
	sleep 1m;
done | lemonbar -f "$FONT" -g "$TimeWidth"\x20+$TimePos+2 -B "$BG"


