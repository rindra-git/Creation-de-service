#!/bin/bash

exclu="\(/boot\|/home\|/\)$"
drive=$(lsblk -lp | grep "t /" | grep -v "exclu" | awk '{print $1, "(" $4 ")", "on" , $7}')
[[ "$drive" = "" ]] && exit 

choice=$(echo "$drive" | dmenu -i -p "dismount? ") | awk '{print $1}'
[[ "$choice" = "" ]] && exit

sudo unmount $choice && pgrep -x dunst && notify-send "$choice deconnected!!! "
