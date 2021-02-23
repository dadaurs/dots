#!/bin/sh
#A few arguments for lemonbar 
if test -f $HOME/.cache/wal/colors.sh; then
 source $HOME/.cache/wal/colors.sh
BG="$color0"
FG="$color7"
BGAOc="$color13" #background of active tags
FGAOc="$color7" #foreground of active and occupied tags
BGAnOc="$color13" #background of active not occupied tags
FGAnOc="$color7" #foreground of active not occupied tags
BGnAOc="$color8" #background of not active and occupied tags
BGnAnOc="$BG" #background of not active and not occupied tags
FGnAnOc="$color7" #foreground of not active not occupied tags
else
BGAOc=#D7B8FE #background of active tags
FGAOc=#F0EEF0 #foreground of active and occupied tags
BGAnOc=#D7B8FE #background of active not occupied tags
FGAnOc=#F0EEF0 #foreground of active not occupied tags
BGnAOc=#3B4252 #background of not active and occupied tags
FGnAOc=#D7B8FE #foreground of not active and occupied tags
BGnAnOc=#1D1B1F #background of not active and not occupied tags
FGnAnOc=#F0EEF0 #foreground of not active not occupied tags
fi


WIDTH=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $2}' ) 
FONT="Iosevka Nerd Font:size=10"
HEIGHT=18
BarWidth=650
BarPosX=$( expr "$WIDTH" - $BarWidth )
BatTimeW=100
PANEL_WM_NAME="lemonbar"




# find dimensions of monitor
WIDTH=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $2}' ) 
#HEIGHT=$( xdpyinfo  | grep -i 'dimensions:' | sed 's:x:\ :' | awk '{print $3}' ) 

#Calculate position of modules.
APPPOS=$(expr "$WIDTH" / 2 - $AppWidth / 2 )
BatTimePos=$(expr "$WIDTH"  - $BatTimeW) 
VolaBackPos=$(expr "$BatTimePos" - $VolaBackW)
#BatPos=$(expr "$TimePos" - $BatWidth - $ModDist) 
MPDTitlePos=$(expr "$VolaBackPos" - $MPDTitleWidth - $ModDist) 
MPDStatusPos=$(expr "$MPDTitlePos" - $MPDTitleWidth ) 

toggle(){
ps -ef | grep "tail -f /tmp/xmonad/cmd_xmonad" | grep -v grep | awk '{print $2}' | while IFS= read -r line;do
	kill $line
done
ps -ef | grep "scripts/lemonbar/bspwm/modules" | grep -v grep | awk '{print $2}' | while IFS= read -r line;do
	kill $line
done
if pgrep -x lemonbar  > /dev/null; then
	pkill lemonbar
	bspc config top_padding 0
	pkill -f $HOME/scripts/lemonbar/bspwm/bar.sh >/dev/null 2>&1
else
	bspc config top_padding $HEIGHT
	showbar
fi
}

showbar(){
bspc subscribe | while IFS= read -r line; do
	sed\
	--posix -e 's/:/\ /g'\
	-e 's/[wW][mM]eDP-[0-9]//g'\
	-e 's/[wW][mM]DP-[0-9]//g'\
	-e 's/meDP-[0-9]//g'\
	-e 's/FDesktop//g'\
	-e 's/\ meDP-[0-9]\ //g'\
	-e 's/MeDP-[0-9]//g'\
	-e 's/WMHDMI-[0-9]//g'\
	-e 's/WmHDMI-[0-9]//g'\
	-e 's/[mM]DP-[0-9]//g'\
	-e 's/Desktop//g'\
	-e 's/LT//g'\
	-e 's/TF//g'\
	-e 's/TT//g'\
	-e 's/T=//g'\
	-e 's/G//g'\
	-e 's/S/[stickied]/g'\
	-e "s/1/%{A:bspc\ desktop\ ssss\ 1:}1%{A}/"\
	-e "s/2/%{A:bspc\ desktop\ ssss\ 2:}2%{A}/"\
	-e "s/3/%{A:bspc\ desktop\ ssss\ 3:}3%{A}/"\
	-e "s/4/%{A:bspc\ desktop\ ssss\ 4:}4%{A}/"\
	-e "s/5/%{A:bspc\ desktop\ ssss\ 5:}5%{A}/"\
	-e "s/6/%{A:bspc\ desktop\ ssss\ 6:}6%{A}/"\
	-e "s/7/%{A:bspc\ desktop\ ssss\ 7:}7%{A}/"\
	-e "s/8/%{A:bspc\ desktop\ ssss\ 8:}8%{A}/"\
	-e "s/9/%{A:bspc\ desktop\ ssss\ 9:}9%{A}/"\
	-e "s/\ O/\ %{B$BGAOc}%{F$FGAOc}\ /g"\
	-e "s/\ o/\ %{F$FGAnOc}%{B$BGnAOc}\ /g"\
	-e "s/\ f/\ %{F$FGnAnOc}%{B$BGnAnOc}\ /g"\
	-e "s/\ u/\ %{F#DC322F}%{B$BGnAnOc}\ /g"\
	-e "s/\ U/\ %{F#DC322F}%{B$BGnAnOc}\ /g"\
	-e "s/\ F/\ %{B$BGAOc}%{F$FGAOc}\ /g"\
	-e "s/\ \ //g"\
	-e "s/10/%{A:bspc\ desktop\ ssss\ 10:}10%{A}/"\
	-e "s/ssss/-f/g"<<< $line

#done 
done | lemonbar  -B $background -g x$HEIGHT -f "$FONT" | sh &
#sleep 0.001

/home/david/scripts/lemonbar/bspwm/modules |  lemonbar -p -g $BarWidth\x$HEIGHT+$BarPosX+0  -f "Font Awesome" -f "$FONT"  -B $BG  -F $FG | sh

}



case $1 in
	'toggle')toggle;;
	'update') toggle && sleep 0.1 && toggle;;
	*)showbar;;
esac

