#!/bin/sh
delim="\ue0b3"
#delim=" "
Battery() {
	STATE=$( acpi | awk '{print $4}' | sed 's/,//')
	echo -e "$delim \x02⚡ $STATE \x01" 
	#echo  -ne "\x05$delim\x06 $STATE"
}


setsong() {
#playlists=$(mpc lsplaylists) 
#subchar="\///' -e 's/^"
current=$(mpc -f "%title%" | sed 1q | grep -v '^volume' |  sed -e 's/\.opus//' -e 's/\.m4a//' -e 's/\.mp3//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e 's/^Unknown\///' -e 's/^rap\///' -e 's/^jazz\///')
echo -e "♬ $current\x01 "
}
setstate() { 
#state=$(mpc | grep 'playing\|paused' | awk '{print $1}' ) 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
#echo -e " $delim $state"
echo -e "$delim \x07$state $delim "
}
#Show time
Day() { 
Date=$(date "+%a %d %b ")
HOUR=$(date "+%H")
TIME=$( date "+%H:%M" )
#echo -n "$DATETIME"
case $HOUR in
	#01|13)  echo -e  "$delim\x04  $TIME\x01";;
	#02|14)  echo -e  "x03$delim\x04  $TIME\x01";;
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
	01|13)  echo -e  "$delim \x08🕐 $Date $delim $TIME\x01";;
	02|14)  echo -e  "$delim \x08🕑 $Date $delim $TIME\x01";;
	03|15)  echo -e  "$delim \x08🕒 $Date $delim $TIME\x01";;
	04|16)  echo -e  "$delim \x08🕓 $Date $delim $TIME\x01";;
	05|17)  echo -e  "$delim \x08🕕 $Date $delim $TIME\x01";;
	06|18)  echo -e  "$delim \x08🕕 $Date $delim $TIME\x01";;
	07|19)  echo -e  "$delim \x08🕖 $Date $delim $TIME\x01";;
	08|20)  echo -e  "$delim \x08🕗 $Date $delim $TIME\x01";;
	09|21)  echo -e  "$delim \x08🕘 $Date $delim $TIME\x01";;
	10|22)  echo -e  "$delim \x08🕙 $Date $delim $TIME\x01";;
	11|23)  echo -e  "$delim \x08🕚 $Date $delim $TIME\x01";;
	12|00)  echo -e  "$delim \x08🕛 $Date $delim $TIME\x01";;
esac
#echo "$delim $TIME"

}
#Finish(){ printf "\x01"
#}



while true; do
if pgrep -x mpd > /dev/null ; then 
	xsetroot -name "$(setstate)$(setsong)$(Battery)$(Day)"
	sh -c  'set -m
		trap "exit" CHLD
		mpc idle & sleep 1m & wait'
	killall mpc
else
	xsetroot -name "$(Battery)$(Day)$(Time)"
	sleep 1m
fi
done


 
