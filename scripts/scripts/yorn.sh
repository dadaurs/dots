#!/bin/sh
D=$(echo -e "Yes\nNo" | dmenu -i -p "Are you sure?")


case $D in
	"Yes")exit 0;;
	*)exit 1;;
esac
