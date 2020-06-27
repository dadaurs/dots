#!/usr/bin/env sh
case $1 in
	*.pdf) echo "$(pwd)/$SEL" | xargs -r zathura  & disown ;;
	*.png) echo  "$(pwd)/$SEL" | xargs -r sxiv & disown ;;
	*.jpg) echo $(pwd)/$SEL | xargs -r sxiv& disown ;;
	*.svg) echo "$(pwd)/$SEL" | xargs -r inkscape& disown ;;
	*.mp4) echo "$(pwd)/$SEL" | xargs -r mpv & disown ;;
	*.mkv) echo "$(pwd)/$SEL" | xargs -r mpv & disown ;;
	www.*.*) tabbed surf -e $1 & disown;;
	*.html) surf $1 & disown;;
	*/) ranger $1 ;;
	*)     echo "$SEL" | xargs -r nvim ;;
esac
