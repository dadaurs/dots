#!/bin/sh

Smart() { 
numwin=$(wmctrl -l | wc -l) 
if [ $numwin -eq 1 ]; then
	bspc config border_width 0
else
	bspc config border_width 2
fi
}
while true; do
	Smart
	bspc subscribe report > /dev/null
done
