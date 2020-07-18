#!/bin/bash
BMFILE="$HOME/.config/qutebrowser/bookmarks/urls"
BROWSER="tabbed surf -e"

SELECT=$(cat $BMFILE | awk '{print $2}' | dmenu -p "Go to?") 


case $SELECT in
	*) cat $BMFILE | grep $SELECT |  awk '{print $1}' | xargs -r0 $BROWSER;;
esac
