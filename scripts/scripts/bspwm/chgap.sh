#!/bin/sh

file="/tmp/bspwm_gapsize"

GapSize=$(cat /tmp/bspwm_gapsize) 
bspc config window_gap > $file

GapsUp() { 
newgap=$(expr $GapSize + $INT) 
bspc config window_gap $newgap
bspc config window_gap > $file
}
GapsDown() { 
newgap=$(expr $GapSize - $INT) 
if [ $GapSize -gt 0 ]; then
	bspc config window_gap $newgap
fi
bspc config window_gap > $file
}
