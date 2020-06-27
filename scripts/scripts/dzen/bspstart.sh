#!/bin/sh

List="
^ca(bspc quit )quit\n
^ca(bspc wm -r )^fg(red)clickme^fg()^ca()\n
^ca(bspc window_gap 10 )gaps\n
^ca(bspc window_gap 0  )no gaps\n
"
echo -e $List 
