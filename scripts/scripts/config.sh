#!/bin/sh
SELECT=$(cat $HOME/scripts/config | dmenu -p "Edit config:") 

case $SELECT in
	zshrc) st -e nvim $HOME/.zshrc;;
	bspwmrc) st -e nvim $HOME/.config/bspwm/bspwmrc && notify-send --urgency=critical --expire-time=3000"$SELECT updated";;
	sxhkdrc) st -e nvim $HOME/.config/sxhkd/sxhkdrc && notify-send --urgency=critical --expire-time=3000"$SELECT updated";;
	dwm) st -e nvim $HOME/suckless/dwm/config.h && cd $HOME/suckless/dwm/ && doas make install && notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	st) st -e nvim $HOME/suckless/st/config.h && cd $HOME/suckless/st/ && doas make install  &&  notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	dmenu) st -e nvim $HOME/suckless/dmenu1/config.h && cd $HOME/suckless/dmenu1/ && doas make install && notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	xinit) st -e nvim $HOME/.xinitrc && notify-send --urgency=critical --expire-time=3000 "$SELECT updated" ;;

esac	
