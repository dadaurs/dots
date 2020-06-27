#! /bin/sh

if pgrep X > /dev/null; then
    [ -z "$DISPLAY" ] && echo "$(basename $0): DISPLAY is not accessible" && exit 1
else
    echo "$(basename $0): No instance of X is running."
    exit 1
fi

if [ -z "$1" ]; then
    for pid in $(pidof -x $0); do
        if [ $pid != $$ ]; then
            echo "$(basename $0): An instance of $(basename $0) is already running."
            exit 0
        fi 
    done
else
    case "$1" in
        --reset)    other_instances=0
                    for pid in $(pidof -x $0); do
                        if [ $pid != $$ ]; then
                            other_instances=$((other_instances+1))
                            kill $pid
                        fi 
                    done
                    if [ $other_instances -gt 0 ]; then
                        setsid bar &
                    fi
                    exit 0
                    ;;
        --switch)   other_instances=0
                    for pid in $(pidof -x $0); do
                        if [ $pid != $$ ]; then
                            other_instances=$((other_instances+1))
                            kill $pid
                        fi 
                    done
                    if [ $other_instances -eq 0 ]; then
                        setsid bar &
                    else
                        bspc config top_padding     "$BSPWM_BOXPADDING_VERT"
                        bspc config left_padding    "$BSPWM_BOXPADDING_VERT"
                        bspc config right_padding   "$BSPWM_BOXPADDING_VERT"
                    fi
                    exit 0
                    ;;
        *)          echo "$(basename $0): unrecognized option '$1'"
                    exit 0
                    ;;
    esac
fi

set -e

BAR_HEIGHT=43
BAR_BG="#090d09"
BAR_FG="#e3dfdf"
BAR_FIFO="/tmp/bar.fifo"
BAR_NAME="$(basename $0)"
FONT_ASCII="Roboto Mono:size=14"
FONT_EMOJI="Font Awesome:size=14"
MODULE_PATH="$HOME/.config/bar"

trap 'rm -f $BAR_FIFO && kill 0' EXIT
mkfifo "$BAR_FIFO"
chmod 600 "$BAR_FIFO"

for module in clock wifi volume battery; do
    $MODULE_PATH/$module.sh > "$BAR_FIFO" &
done

bspc config top_padding     "$(( $BAR_HEIGHT  $BSPWM_BOXPADDING_VERT ))"
bspc config left_padding    "$BSPWM_BOXPADDING_HORZ"
bspc config right_padding   "$BSPWM_BOXPADDING_HORZ"

MONITOR_COUNT=$(xrandr | grep -w connected | awk -F'[ +]' '{print $1}' | wc -l)

while IFS='' read -r line; do
    case "$line" in
        C*) clck="${line#?}" ;;
        V*) volm="${line#?}" ;;
        W*) wifi="${line#?}" ;;
        B*) batt="${line#?}" ;;
    esac
    LEFT="${clck}"
    RIGHT="${volm}${wifi}${batt}"
    IFS=' '
    set -- $(seq -s ' ' $MONITOR_COUNT)
    while [ $# -gt 0 ]; do
        SCREEN=$(($1-1))
        BAR_OUT="$BAR_OUT%{S${SCREEN}}%{l}  ${LEFT}%{r}${RIGHT}  "
        shift
    done
    printf "%s\n" "$BAR_OUT"
    unset BAR_OUT
done < "$BAR_FIFO" | lemonbar -f "$FONT_ASCII" -f "$FONT_EMOJI" -g "x$BAR_HEIGHT" -n "$BAR_NAME" -B "$BAR_BG" -F "$BAR_FG" | sh &

BAR_WID="$(xdo id -m -a $BAR_NAME)"
for wid in $BAR_WID; do
    xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"
done

#wait

