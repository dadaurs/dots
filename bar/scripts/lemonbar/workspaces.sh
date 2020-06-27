#!/bin/sh

#worskpaces in bspwm using bspc socket

curws="B34C23"
showws() { 
echo $1 | sed -e 's/:/\ /g' -e 's/WMeDP1//g' -e 's/LT//g' -e 's/TT//g' -e 's/G//g'  -e 's/O/%{U#4D688A}%{F#4D688A}%{!u}/' -e 's/\ F/\ %{U#4D688A}%{F#4D688A}%{!u}/' -e 's/\ o/%{-u}\ %{-u}%{F#87A7B2}/g' -e 's/\ u/%{-u}\ %{-u}%{F#87A7B2}/g' -e 's/\ f/%{-u}\ %{-u}%{F#D9CBBE}/g'
}
while true; do
	state=$(bspc subscribe -c 1 report)
	showws $state
	bspc subscribe -c 2 report > /dev/null	
done
