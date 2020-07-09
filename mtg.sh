#!/bin/bash
pgrep -x dmenu && exit
mtg=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[[ "$mtg" = "" ]] && exit 1
choice=$(echo "$mtg" | dmenu -i -p "your choice: " | awk '{print $1}')
[[ "$choice" = "" ]] && exit 1
sudo mount "$choice" && exit 1
src=$(find /mnt /media /mount /home -type d -maxdepth 3 2>nul.txt)
mtgpoint=$(echo "$src" | dmenu -i -p "lector mtg. ")
[[ "$mtgpoint" = "" ]] && exit 1
if [[ ! -d "$mtgpoint" ]] && exit 1
then
    mkdiryn=$(echo -e "oui/non" | dmenu -i -p "$mtgtpoint, insert mountpoint: ")
    [[ "$mkdiryn" = yes ]] && sudo mkdir -p "$mtgpoint"
fi
sudo mount $choice $mtgpoint && pgrep -x dunst && notify-send "$choice connected !!!"   
cd $choice
echo $(date) + %H > dte.text
b =0
while (( $b == 0))
do
    read -p " would you want deconnect y/n: " dec
    case $dec in
        y)
            ./dmt.sh
            b=1
            break;;
        n)
            echo " ok "
            b=1
            break;;
        *)    
            b=0
            break;;
    esac
done
