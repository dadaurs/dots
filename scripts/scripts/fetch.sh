#!/bin/sh

memory=$(free -m | awk '/Mem:/ {print $3"M / "$2"M"}')
distro=$(cat /etc/os-release | sed -e '1!d' -e 's/NAME=//g')
username=$(whoami)
shell=$(echo "$SHELL" | sed -e 's/\/bin\///g')
cpu=$(cat /proc/cpuinfo | grep -e 'model name' | sed -e '1!d' -e 's/model name//g' -e 's/(R).Core(TM)//g' -e 's/CPU//g' -e 's/  @//g' -e 's/://g' -e 's/^[ \t]*//')

clear
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
	reset="$(tput sgr0)"
fi
c0="${reset}${magenta}"      # first color
c1="${reset}${white}"      # first color

cat <<EOF

${c0}    .----.   @   @   ${c1}  $username
${c0}   / .-\"-.\`.  \\v/ ${c1}    $distro
${c0}   | | '\ \ \_/ )    ${c1}  $shell
${c0} ,-\ \`-.' /.'  /    ${c1}   $cpu
${c0}'---\`----'----'     ${c1}   $memory

EOF
