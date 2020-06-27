#!/bin/sh
showbut() {
	#echo -e "^i(~/Downloads/2000px-Gentoo_Linux_logo_matte.svg.xbm)"
#st\n
#browser\n
#libreoffice\n
#gimp\n
#firefox\n
#chromium
#"
listapps="^i(gentoo2.xbm)\n
^ca(1, st )terminal^ca()\n
^ca(1, browser )qutebrowser^ca()\n
^ca(1 , libreoffice )libreoffice^ca()\n
^ca(1, gimp )Gimp^ca()\n
^ca(1, firefox )firefox^ca()\n
^ca(1, chromium )chromium^ca()
"
echo -e $listapps
}
showbut | dzen2 -expand right  -p -w '100' -h '15' -fg '#000000' -bg '#FFFFFF' -l '6' -m
