#!/bin/sh
GapSize=$(bspc config window_gap) 
INT=1


GapsUp() { 
newgap=$(expr $GapSize + $INT) 
bspc config window_gap $newgap
}
GapsDown() { 
newgap=$(expr $GapSize - $INT) 
if [ $GapSize -eq 0 ]; then
	bspc config window_gap 0
else
	bspc config window_gap $newgap
fi
}
GapsToggle() { 
if [ $GapSize -gt 0 ]; then
	bspc config window_gap 0
else
	bspc config window_gap 15
fi
}
case $1 in
	up) GapsUp;;
	down) GapsDown;;
	toggle) GapsToggle;;
esac
	
