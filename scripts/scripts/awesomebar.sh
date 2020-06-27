delim=" | "
Status() {
	VOLUME=$( pactl list sinks | grep '^[[:space:]]Volume:' | awk '{print $5}')
	echo -n "$delim"
	echo -n "V:$VOLUME"
	echo -n "$delim"
	DATETIME=$(date "+%a %b %d, %H:%M")
	echo -n "$DATETIME"
	echo -n "$delim"
	BATTERY=$(acpi | awk '{print $4}')
	echo -n "B:$BATTERY"
}
while true; do
	echo -n "$(Status)"
	sleep 1m
done


 
