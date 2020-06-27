#!/bin/sh
SELECT=$(cat /home/dada/scripts/config | dmenu -p "Edit config:") 

case $SELECT in
	zshrc) st -e nvim /home/dada/.zshrc;;
	bspwmrc) st -e nvim /home/dada/.config/bspwm/bspwmrc && notify-send --urgency=critical --expire-time=3000"$SELECT updated";;
	sxhkdrc) st -e nvim /home/dada/.config/sxhkd/sxhkdrc && notify-send --urgency=critical --expire-time=3000"$SELECT updated";;
	dwm) st -e nvim /home/dada/suckless/dwm/config.h && cd /home/dada/suckless/dwm/ && doas make install && notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	st) st -e nvim /home/dada/suckless/st/config.h && cd /home/dada/suckless/st/ && doas make install  &&  notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	dmenu) st -e nvim /home/dada/suckless/dmenu1/config.h && cd /home/dada/suckless/dmenu1/ && doas make install && notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	xinit) st -e nvim /home/dada/.xinitrc && notify-send --urgency=critical --expire-time=3000 "$SELECT updated" ;;

esac	
