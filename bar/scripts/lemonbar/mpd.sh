#!/bin/sh
setsong() {
current=$(mpc -f "%title%" | sed 1q)
#current=$(mpc | grep -v "volume\|playing\|paused" | sed 's/\.opus//'| sed 's/\.m4a//' | sed -e 's/^chill\///' -e  's/^country\///' -e  's/^TheAlgorithm\///' -e  's/^Bootleg\///' -e  's/^DiverseSystem\///' )
echo -n $current
}
setstate() { 
state=$(mpc | grep 'playing\|paused' | awk '{print $1}' | sed 's/\[playing\]//' | sed 's/\[paused\]//') 
echo -n %{A:mpc toggle:}$state%{A}
}

while true; do
echo "%{F#ffffff}%{A:mpc prev:} %{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}%{A}%{F#ffffff}  $(setsong)"
#echo "%{F#ffffff}%{A:mpc prev:}⏪%{A}%{F#ffffff}$(setstate) %{F#ffffff}%{A:mpc next:}⏩%{A}%{F#ffffff}$(setsong)"
mpc idle >/dev/null
done
