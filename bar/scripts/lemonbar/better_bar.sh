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
MPDWidth=200
WsPos=2
ModDist=10

PANEL_WM_NAME="lemonbar"
mkfifo /tmp/ws_file
mkfifo /tmp/bat_file
mkfifo /tmp/song_file
mkfifo /tmp/state_file
mkfifo /tmp/time_file
mkfifo /tmp/app_file

#Battery module, show percentage and change color if charging.
Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	echo " %{F#EA7866}$STATE"
}

#Show currently open app, make a few substitutions for commonly used apps.

getApp(){
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  case $app in
	  st|xst|urxvt) echo  ">_";;
	  qutebrowser) echo  "qb";;
	  soffice\.bin) echo  "LibreOffice";;
	  #qutebrowser) echo  "💿";;
	  "") echo  " desktop";;
	  *) echo  "$app";;
 esac
}

#Show currently playing song in mpd as well as its state.

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
echo "$TIME"
}


#Show current worskpace in bspwm
showws() { 
echo "$1" | sed --posix -e 's/:/\ /g'\
	-e 's/WMeDP1//g'\
	-e 's/WMeDP-1//g'\
	-e 's/LT//g'\
	-e 's/TF//g'\
	-e 's/TT//g'\
	-e 's/G//g'\
	-e "s/\ O/\ %{B$BGAOc}%{F$FGAOc}\ /"\
	-e "s/\ o/\ %{F$FGAnOc}%{B$BGnAOc}\ /g"\
	-e "s/\ f/\ %{F$FGnAnOc}%{B$BGnAnOc}\ /g"\
	-e "s/\ u/\ %{F#DC322F}/g"\
	-e "s/\ F/\ %{B$BGAOc}%{F$FGAOc}\ /"
}
mainloop(){
while true; do
	state=$(bspc subscribe -c 1 report)
	showws "$state" > $ws_file
	Printall
	bspc subscribe -c 2 report > /dev/null
done &

while true; do
	echo "%{F#FECC6D}⚡$(Battery)" > $bat_file
	Printall
	#echo "%{l}%{F#FECC6D}⚡$(Battery)"
	#echo "%{B#000433}%{l}%{F#FECC6D}⚡$(Battery)"
	sleep 1m
done &

while true; do
echo " %{F#D9CBBE}$(getApp) " > $app_file
Printall
bspc subscribe -c 2 report > /dev/null
done &
#while true; do
	#if pgrep -x mpd > /dev/null || pgrep -x mopidy >/dev/null
	#then
		#echo "%{F$FG}%{A:mpc prev:} %{A}%{F$FG}$(setstate) %{F$FG}%{A:mpc next:} %{A}%{F$FG}  $(setsong)" > $song_file
		#Printall
		#mpc idle >/dev/null
	#else
		#echo ""
		#sleep 1m
	#fi
#done &

#while true; do
	#echo "%{F$FG}$(Time) "
	#Printall
	##echo " %{B#000433} $(Date) "
	#sleep 1m
#done &
}
Printall(){
    echo -n "%{l}"
    cat $ws_file 
    # cat $ws_file $app_file  $state_file  $time_file 
}

mainloop | lemonbar -n "$PANEL_WM_NAME" -f "$FONT"  &
