#!/bin/sh
delim=" "
#delim=" | "
Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	#echo -ne "$delim ⚡ $STATE " 
	echo  -ne "\x05$delim\x06 $STATE"
}


setsong() {
#playlists=$(mpc lsplaylists) 
#subchar="\///' -e 's/^"
current=$(mpc -f "%file%" | sed 1q | grep -v '^volume' |  sed -e 's/\.opus//' -e 's/\.m4a//' -e 's/\.mp3//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^rap\///' -e 's/^jazz\///')
#echo -ne "$current"
echo -ne "$current\x08"
}
setstate() { 
#state=$(mpc | grep 'playing\|paused' | awk '{print $1}' ) 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
echo -ne " $delim $state"
#echo -ne "\x09 $delim\x07 $state"
}
#Show time
Time() { 
TIME=$( date "+%H:%M:%S" )
HOUR=$( date "+%H") 
#echo -n "$DATETIME"
case $HOUR in
	#01|13)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#02|14)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#03|15)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#04|16)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#05|17)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#06|18)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#07|19)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#08|20)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#09|21)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#10|22)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#11|23)  echo -e  "\x03$delim\x04  $TIME\x01";;
	#12|00)  echo -e  "\x03$delim\x04  $TIME\x01";;
	01|13)  echo -ne  "\x03$delim\x04 🕐 $TIME";;
	02|14)  echo -ne  "\x03$delim\x04 🕑 $TIME";;
	03|15)  echo -ne  "\x03$delim\x04 🕒 $TIME";;
	04|16)  echo -ne  "\x03$delim\x04 🕓 $TIME";;
	05|17)  echo -ne  "\x03$delim\x04 🕕 $TIME";;
	06|18)  echo -ne  "\x03$delim\x04 🕕 $TIME";;
	07|19)  echo -ne  "\x03$delim\x04 🕖 $TIME";;
	08|20)  echo -ne  "\x03$delim\x04 🕗 $TIME";;
	09|21)  echo -ne  "\x03$delim\x04 🕘 $TIME";;
	10|22)  echo -ne  "\x03$delim\x04 🕙 $TIME";;
	11|23)  echo -ne  "\x03$delim\x04 🕚 $TIME";;
	12|00)  echo -ne  "\x03$delim\x04 🕛 $TIME";;
	#01|13)  echo -ne  "$delim 🕐 $TIME";;
	#02|14)  echo -ne  "$delim 🕑 $TIME";;
	#03|15)  echo -ne  "$delim 🕒 $TIME";;
	#04|16)  echo -ne  "$delim 🕓 $TIME";;
	#05|17)  echo -ne  "$delim 🕕 $TIME";;
	#06|18)  echo -ne  "$delim 🕕 $TIME";;
	#07|19)  echo -ne  "$delim 🕖 $TIME";;
	#08|20)  echo -ne  "$delim 🕗 $TIME";;
	#09|21)  echo -ne  "$delim 🕘 $TIME";;
	#10|22)  echo -ne  "$delim 🕙 $TIME";;
	#11|23)  echo -ne  "$delim 🕚 $TIME";;
	#12|00)  echo -ne  "$delim 🕛 $TIME";;
esac
#echo "$delim $TIME"

}
Finish(){ printf "\x01"
}
Status(){
setstate
setsong 
Battery
Time
Finish
}

status+="$(setstate)  "
status+="$(setsong)"
status+="$(Battery)"
status+="$(Time)"


while true; do
if pgrep -x mpd > /dev/null ; then 
	#xsetroot -name "$(Battery)$(Time)"
	xsetroot -name "$status"
	#printf  "%s" "$status"
	sh -c 'set -m
	trap "xsetroot -name "$status"" SIGTRAP'
	sh -c  'set -m
		trap "exit" CHLD
		mpc idle & sleep 1m & wait'
		killall mpc
else
	xsetroot -name "$(Battery)$(Time)"
	sleep 1m
fi
done


 
