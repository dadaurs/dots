#!/bin/sh
#                           ██            ████                
#                          ░░            ░██░                 
#   ██████  ██   ██  ██████ ██ ███████  ██████  ██████ 
#  ██░░░░  ░░██ ██  ██░░░░ ░██░░██░░░██░░░██░  ██░░░░██
# ░░█████   ░░███  ░░█████ ░██ ░██  ░██  ░██  ░██   ░██
#  ░░░░░██   ░██    ░░░░░██░██ ░██  ░██  ░██  ░██   ░██
#  ██████    ██     ██████ ░██ ███  ░██  ░██  ░░██████ 
# ░░░░░░   ██      ░░░░░░  ░░ ░░░   ░░   ░░    ░░░░░░  
#        ░░      
#
#  ▓▓▓▓▓▓▓▓▓▓
# ░▓ author ▓ xero <x@xero.nu>
# ░▓ code   ▓ http://code.xero.nu/dotfiles
# ░▓ mirror ▓ http://git.io/.files
# ░▓▓▓▓▓▓▓▓▓▓
# ░░░░░░░░░░
#
#█▓▒░ vars
#FULL=▓
#EMPTY=░
FULL=━
#EMPTY=━
#EMPTY=─
#FULL=┅
EMPTY=┄

name=$USER
host=`hostname`
battery=/sys/class/power_supply/BAT1
distro=$(cat /etc/os-release | sed -e '1!d' -e 's/NAME=//g')
kernel=`uname -sr`
packages="$(ls -d /var/db/pkg/*/* | wc -l)"
#wm='2bwm'
if [ -n "${DE}" ]; then
        wm="${DE}"
        uitype='DE'
elif [ -n "${WM}" ]; then
        wm="${WM}"
        uitype='WM'
elif [ -n "${XDG_CURRENT_DESKTOP}" ]; then
        wm="${XDG_CURRENT_DESKTOP}"
        uitype='DE'
elif [ -n "${DESKTOP_SESSION}" ]; then
        wm="${DESKTOP_SESSION}"
        uitype='DE'
elif [ -f "${HOME}/.xinitrc" ]; then
        wm="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
        uitype='WM'
elif [ -f "${HOME}/.xsession" ]; then
        wm="$(tail -n 1 "${HOME}/.xsession" | cut -d ' ' -f 2)"
        uitype='WM'
else
        ui='unknown'
        uitype='UI'
fi


#█▓▒░ progress bar
draw()
{
  perc=$1
  size=$2
  inc=$(( perc * size / 100 ))
  out=
  if [ -z $3 ]
  then
    color="36"
  else
    color="$3"
  fi 
  for v in `seq 0 $(( size - 1 ))`; do
    test "$v" -le "$inc"   \
    && out="${out}\e[1;${color}m${FULL}" \
    || out="${out}\e[0;${color}m${EMPTY}"
  done
  printf $out
}

#█▓▒░ colors
#printf "\n"
#i=0
#while [ $i -le 6 ]
#do
  #printf "\e[$((i+41))m\e[$((i+30))m█▓▒░"
  #i=$(($i+1))
#done
#printf "\e[37m█\e[0m▒░\n\n"


#█▓▒░ greets
printf " \e[0m\n"

#█▓▒░ environment
printf " \e[1;33m      distro \e[0m$distro\n"
printf " \e[1;33m      kernel \e[0m$kernel\n"
printf " \e[1;33m          wm \e[0m$wm\n"
printf " \e[1;33m         pkg \e[0m$packages\n"
printf " \e[0m\n"

#█▓▒░ cpu
cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
c_lvl=`printf "%.0f" $cpu`
printf "   \e[0;36m%-4s \e[1;36m%-5s %-25s \n" " cpu" "$c_lvl%" `draw $c_lvl 15` 

#█▓▒░ ram
ram=`free | awk '/Mem:/ {print int($3/$2 * 100.0)}'`
printf "   \e[0;36m%-4s \e[1;36m%-5s %-25s \n" " ram" "$ram%" `draw $ram 15` 




