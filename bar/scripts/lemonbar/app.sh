getApp() {
  app=$(ps -e | grep $(xdotool getwindowpid $(xdotool getwindowfocus)) | grep -v grep | awk '{print $4}')
  case $app in
	  st|xst|urxvt) echo -n ">_";;
	  qutebrowser) echo -n "qb";;
	  soffice\.bin) echo -n "LibreOffice";;
	  #qutebrowser) echo -n "💿";;
	  "") echo -n "desktop";;
	  *) echo -n "$app";;
 esac
}

while true; do
echo " %{c}%{F#D9CBBE}$(getApp) "
bspc subscribe -c 2 report > /dev/null
done
