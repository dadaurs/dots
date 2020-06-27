#!/usr/bin/env sh
list="surf\nfirefox\nqutebrowser"
url=$(xsel --clipboard --output)

choice=$(echo -e $list | dmenu -p "Open $url in?")

case $choice in
	"surf") surf $url;;
	"qutebrowser") qutebrowser --target window $url;;
	"firefox") firefox $url;;
	*) exit 1;;
esac

