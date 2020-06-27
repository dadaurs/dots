#!/bin/sh
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
			echo " %{F#00FF00}$STATE  " 
			#echo "%{B#000433} %{F#00FF00}$STATE  " 
	esac
}

while true; do
	echo "%{l}%{F#FECC6D}⚡$(Battery)"
	#echo "%{B#000433}%{l}%{F#FECC6D}⚡$(Battery)"
	sleep 1m;
done
