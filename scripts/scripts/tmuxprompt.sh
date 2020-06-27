#!/bin/sh

CHOICE=$(echo -e "attach\nnew\nnone" | dmenu -i -p "Tmux session?")
#SEL=$(tmux ls | fzf | awk '{print $1}' | sed 's/://')
case $CHOICE in
	attach) tmux attach-session -t $(tmux ls | dmenu -i -p "Wich one?" | awk '{print $1}' | sed 's/://');;
	new) tmux;;
	none) zsh;;
esac

