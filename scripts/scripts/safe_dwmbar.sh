#!/bin/sh
delim="|"
Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	echo -ne " ⚡ $STATE " 
	#echo  -ne "\x05$delim\x06 $STATE"
}


setsong() {
#playlists=$(mpc lsplaylists) 
#subchar="\///' -e 's/^"
current=$(mpc -f "%file%" | sed 1q | grep -v '^volume' |  sed -e 's/\.opus//' -e 's/\.m4a//' -e 's/\.mp3//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^rap\///' -e 's/^jazz\///')
echo -ne "$current\x08"
}
setstate() { 
#state=$(mpc | grep 'playing\|paused' | awk '{print $1}' ) 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
echo -ne "\x09 $delim\x07 $state"
}
#Show time
Time() { 
TIME=$( date "+%H:%M" )
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
	01|13)  echo -ne  "🕐 $TIME";;
	02|14)  echo -ne  "🕑 $TIME";;
	03|15)  echo -ne  "🕒 $TIME";;
	04|16)  echo -ne  "🕓 $TIME";;
	05|17)  echo -ne  "🕕 $TIME";;
	06|18)  echo -ne  "🕕 $TIME";;
	07|19)  echo -ne  "🕖 $TIME";;
	08|20)  echo -ne  "🕗 $TIME";;
	09|21)  echo -ne  "🕘 $TIME";;
	10|22)  echo -ne  "🕙 $TIME";;
	11|23)  echo -ne  "🕚 $TIME";;
	12|00)  echo -ne  "🕛 $TIME";;
esac
#echo "$delim $TIME"

}
Finish(){
printf "\x01"
}
Status(){
setstate
setsong 
Battery
Time
Finish
}

while true; do
	xsetroot -name "$(Battery) $delim $(Time)"
	sleep 1m
done


 
