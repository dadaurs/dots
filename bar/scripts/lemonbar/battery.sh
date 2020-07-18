#!/bin/bash
Battery() {
	command -v acpi > /dev/null || return 1

	local battery_label battery_status battery_output battery_status_time

	battery_label='B:'
	battery_status="$(acpi -b | awk -F '[[:space:]]+|,' '{ print $3 }')"
	battery_output="$(acpi -b | awk -F '[[:space:]]+|,' '{ print $5 }')"

	# If dischange level reaches 0-9, the whole indicator will turn to
	# a bright colour.  Otherwise, discharging will be denoted by
	# a coloured output of the current level followed by the minus sign.
	case "$battery_status" in
		'Charging')
			echo "$battery_label %{F#00FF00}${battery_output}+%{F-}  "
			;;
		'Discharging')
			case "${battery_output%?}" in
				[0-9])
					echo "%{F#FF0000} $battery_label ${battery_output}- %{F-}%{B-}  "
					;;
				*)
					echo "$battery_label %{F$color11}${battery_output}-%{F-}  "
					;;
			esac
			;;
		*)
			echo "$battery_label ${battery_output}  "
			;;
	esac
}
indicator() {
  SPACES=$(bspc query -D)
  BUSY=$(bspc query -D -d .occupied)
  C=1

  for SPACE in $SPACES
  do
    CHAR="\uf111"
    case "$C" in
      "1")
	CHAR="  I"
	;;
      "2")
	CHAR="  II"
	;;
      "3")
	CHAR="  III"
	;;
      "4")
	CHAR="  IV"
	;;
      "5")
	CHAR="  V"
	;;
      "6")
	CHAR="  VI"
	;;
      "7")
	CHAR="  VII"
	;;
      "8")
	CHAR="  VIII"
	;;
      "9")
	CHAR="  IX"
    ;;
    esac
    if [[ $SPACE = $(bspc query -D -d) ]]; then
      echo -n "$CHAR"
    fi
    C=$(( C + 1 ))
  done
}
#indicator() { 
	#echo $($HOME/scripts/lemonbar/workspaces.py)
#}

getApp() {
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  if [ "$app" = "" ]; then
    app="desktop"
  fi
  echo -n $app
}

Clock() {
DATETIME=$( date "+%a %b %d, %H:%M:%S" )
echo -n "$DATETIME"
}
#Music() {
	#CURRENT="$( mpc current ) |"
	#if [ "$CURRENT" = "MPD Error: Connection refused" ]; then
		#CURRENT=""
	#fi
	#if [ "$CURRENT"= "\n" ]; then
		#CURRENT=""
	#fi
	#echo "$CURRENT"
#}
while true; do
	echo "%{l}%{A:dropdmenu_run -w 300 -x 220 -y 20:} "0" %{A}%{l}$(indicator)  %{c}$( getApp ) %{r}$( Clock ) |  %{r}$( Battery ) "
	#echo " %{c}$( getApp ) %{r}$( Clock ) |  %{r}$( Battery ) "
	#echo "$(indicator) "
	sleep 1;
done
