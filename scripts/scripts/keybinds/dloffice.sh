#!/bin/sh
URL=$(xsel --clipboard --output) 
SEASON=$(echo -e "1\n2\n3\n4\n5\n6\n7\n8\n9" | dmenu -i -p "Wich Season?") 
EP=$(echo -e "\n" | dmenu -p "What number?") 
NAME=$(echo -e "\n" | dmenu -p "What name?") 

DL() { 
cd ~/media/films/TheOffice/S$SEASON
wget $URL -O "$EP-$NAME"
}
