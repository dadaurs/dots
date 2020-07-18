#!/bin/sh

SEL=$(cat options | dropdmenu -w 400)

case $SEL in
	config) st -e nvim $HOME/suckless/dwm/config.h && cd $HOME/suckless/dwm/ && doas make install && notify-send --urgency=critical --expire-time=3000 "$SELECT recompiled" ;;
	restart)killall dwm && startx;;
	quit) killall dwm;;
esac


