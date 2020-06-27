#!/bin/sh

Vol() {
	echo -e "Volume"
	(
	pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
	) | gdbar -max 100 -min 0 -s '-'
}

Vol
#) | dbar -max 100 -min 0 -s '-' | sed -e 's/[[:space:]][0-9][0-9]%//'
#(
#pactl list sinks | grep '^[[:space:]]Volume' | awk '{print $5}'
#) | dbar -max 100 -min 0 -s '-' | sed -e 's/[0-9]//g' -e 's/%//g' -e 's/^[[:space:]]//' -e 's/^[[:space:]]//' -e 's/\[//' -e 's/\]//' 
