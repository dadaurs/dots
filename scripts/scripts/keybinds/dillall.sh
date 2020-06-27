#!/bin/sh

dmenu_path | dmenu -p "KILLALL" | xargs -r killall

