#!/bin/sh
#Script to download images, video and audio.
URL=$(xsel --clipboard --output) 
DMENUOPTS="-w 500"
Yout() { 
	CHOICE=$( echo -e "Video\nAudio\nBoth" | dropdmenu $DMENUOPTS -i -p "Download Video, audio or both?")
	LOC=$(echo -e "Bootleg\nchill\ncountry\nplaylists\nTheAlgorithm\nUnknown"| dropdmenu $DMENUOPTS  -i -p "To wich location?") 
	case $CHOICE in
		Video)cd ~/music/$LOC && youtube-dl $URL && notify-send "$URL downloaded!";;
		Audio)cd ~/music/$LOC && youtube-dl -x $URL && notify-send "$URL downloaded!";;
		Both)cd ~/music/$LOC && youtube-dl $URL && youtube-dl -x $URL && notify-send "$URL downloaded!";;
	esac
}
case $URL in
	*.youtube.*) Yout;;
	*.wallhaven.*)cd ~/wallpapers && wget $1;;
	magnet*) cd media && transmission-remote -a $1;;
	*.soundcloud.com*)Yout;;
	*) wget $URL ^^ notify-send "$URL finished downloading";;
esac
