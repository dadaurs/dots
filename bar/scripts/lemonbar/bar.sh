#!/bin/sh
#A few arguments for lemonbar 
if test -f $HOME/.cache/wal/colors.sh; then
 source $HOME/.cache/wal/colors.sh
BG="$color0"
FG="$color7"
BGAOc="$color13" #background of active tags
FGAOc="$color7" #foreground of active and occupied tags
BGAnOc="$color13" #background of active not occupied tags
FGAnOc="" #foreground of active not occupied tags
BGnAOc="$color8" #background of not active and occupied tags
BGnAnOc="$BG" #background of not active and not occupied tags
FGnAnOc="$color7" #foreground of not active not occupied tags
else
BGAOc=#D7B8FE #background of active tags
FGAOc=#F0EEF0 #foreground of active and occupied tags
BGAnOc=#D7B8FE #background of active not occupied tags
FGAnOc=#F0EEF0 #foreground of active not occupied tags
BGnAOc=#3B4252 #background of not active and occupied tags
FGnAOc=#D7B8FE #foreground of not active and occupied tags
BGnAnOc=#1D1B1F #background of not active and not occupied tags
FGnAnOc=#F0EEF0 #foreground of not active not occupied tags
fi

FONT="Iosevka Nerd Font:size=9"
HEIGHT=17
AppWidth=100
WSWidth=300
WSHeight=20
BatWidth=60
TimeWidth=70
MPDWidth=220
WsPos=2
ModDist=10

PANEL_WM_NAME="lemonbar"




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
	#battery_status="$(acpi -b | awk -F '[[:space:]]+|,' '{ print $3 }')"
	#case "$battery_status" in
		#'Charging')
			#echo " %{F#EA7866}$STATE  " ;;
			##echo "%{B#000433} %{F#EA7866}$STATE  " ;;
		#'Discharging')
			#echo " %{F#CE6864}$STATE  " ;;
			##echo "%{B#000433} %{F#CE6864}$STATE  " ;;
		#'Full') 
			#echo " %{F#B5BD68}$STATE  " 
			##echo "%{B#000433} %{F#00FF00}$STATE  " 
	#esac
	echo " %{F#EA7866}$STATE"
}

#Show currently open app, make a few substitutions for commonly used apps.

getApp(){
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  case $app in
	  st|xst|urxvt) echo  "%{c}>_";;
	  qutebrowser) echo  "%{c}qb";;
	  soffice\.bin) echo  "%{c}LibreOffice";;
	  #qutebrowser) echo  "💿";;
	  "") echo  "%{c} desktop";;
	  *) echo  "%{c}$app";;
 esac
}

#Show currently playing song in mpd as well as its state.

setsong() {
#current=$(mpc | grep -v "volume\|playing\|paused" | sed 's/\.opus//'| sed 's/\.m4a//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^DiverseSystem\///' )
current=$(mpc -f "%title%" | sed 1q)
#current=$(mpc | grep -v "volume\|playing\|paused" | sed 's/\.opus//'| sed 's/\.m4a//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^DiverseSystem\///' )
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
echo "$1" | sed --posix -e 's/:/\ /g'\
	-e 's/WMeDP1//g'\
	-e 's/LT//g'\
	-e 's/TF//g'\
	-e 's/TT//g'\
	-e 's/G//g'\
	-e "s/\ O/\ %{B$BGAOc}%{F$FGAOc}\ /"\
	-e "s/\ o/\ %{F$FGAnOc}%{B$BGnAOc}\ /g"\
	-e "s/\ f/\ %{F$FGnAnOc}%{B$BGnAnOc}\ /g"\
	-e "s/\ u/\ %{F#DC322F}/g"\
	-e "s/\ F/\ %{B$BGAOc}%{F$FGAOc}\ /"



	#-e 's/WMeDP1//g'\
	#-e 's/LT//g'\
	#-e 's/TT//g'\
	#-e 's/G//g'\
	#-e 's/O/%{U#A54242}%{F#A54242}%{!u}/'\
	#-e 's/\ F/\ %{U#A54242}%{F#D9CBBE}%{!u}/'\
	#-e 's/\ o/%{-u}\ %{-u}%{F#A54242}/g'\
	#-e 's/\ u/%{-u}\ %{-u}%{F#87A7B2}/g'\
	#-e 's/\ f/%{-u}\ %{-u}%{F#D9CBBE}/g' 
}
#First print a grey bar containing nothing, we then print modules on top of it.
showbar(){
echo " " | lemonbar -n "$PANEL_WM_NAME"  -p  -B "$BG" -g \x20 &
#BSPWM worskpace detection
while true; do
	state=$(bspc subscribe -c 1 report)
	showws "$state"
	bspc subscribe -c 2 report > /tmp/tests
done | lemonbar -n "$PANEL_WM_NAME" -a 9 -f "$FONT" -g $WSWidth\x$HEIGHT+$WsPos+2 -B $BG -u 2 &

#Battery level detection
while true; do
	echo "%{l}%{F#FECC6D}⚡$(Battery)"
	#echo "%{l}%{F#FECC6D}⚡$(Battery)"
	#echo "%{B#000433}%{l}%{F#FECC6D}⚡$(Battery)"
	sleep 1m
done | lemonbar -n "$PANEL_WM_NAME" -f "$FONT" -g $BatWidth\x$HEIGHT+$BatPos+2 -B $BG&

#current app detection
while true; do
echo " %{c}%{F#D9CBBE}$(getApp) "
bspc subscribe -c 2 report > /dev/null
done | lemonbar -n "$PANEL_WM_NAME" -f "$FONT" -g $AppWidth\x$HEIGHT+$APPPOS+2 -B $BG&

#MPD detection
while true; do
	if pgrep -x mpd > /dev/null
	then
		echo "%{F$FG}%{A:mpc prev:} %{A}%{F$FG}$(setstate) %{F$FG}%{A:mpc next:}%{A}%{F$FG}  $(setsong)"
		mpc idle >/dev/null
	else
		echo ""
		sleep 1m
	fi
#echo "%{F#ffffff}%{A:mpc prev:}⏪%{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}⏩%{A}%{F#ffffff}$(setsong)"
done | lemonbar -n "$PANEL_WM_NAME" -f "$FONT" -g $MPDWidth\x$HEIGHT+$MPDPos+2 -B $BG| sh &

#Time detection
while true; do
	echo "%{c}%{F$FG}$(Time) "
	#echo " %{B#000433} $(Date) "
	sleep 1m;
done | lemonbar -n "$PANEL_WM_NAME" -f "$FONT" -g "$TimeWidth"\x$HEIGHT+$TimePos+2 -B "$BG"&
}

#!/bin/sh
showit() { 
#wid=$(xdo id -a "$PANEL_WM_NAME")
#while read -r line;do
	#xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$line"
#done <<< "$wid"
bspc config top_padding 20
showbar
}
toggle(){
if pgrep -x lemonbar  > /dev/null; then
	pkill lemonbar
	bspc config top_padding 0
	pkill -f /home/dada/scripts/lemonbar/bar.sh >/dev/null 2>&1
else
	bspc config top_padding $HEIGHT
	showbar
fi
}
update(){
	pkill lemonbar 
	pkill mpc
	showit

}
case $1 in
	'toggle') toggle;;
	'suppress')Killbar;;
	'show') showit;;
	*)update;;
esac


