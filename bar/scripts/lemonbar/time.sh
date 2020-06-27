Date() { 
TIME=$( date "+%H:%M" )
HOUR=$( date "+%H") 
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
echo $TIME
}

while true; do
	echo "%{c}%{F#ffffff}$(Date) "
	#echo " %{B#000433} $(Date) "
	sleep 1m;
done
