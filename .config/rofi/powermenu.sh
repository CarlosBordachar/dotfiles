#!/bin/env bash

#source: https://github.com/EndeavourOS-Community-Editions/bspwm/blob/main/.config/rofi/powermenu.sh 

# Options for powermenu
lock="󰍁  : Lock Screen"
logout="  : Logout | Close Session"
shutdown="  : Shutdown | Power Off"
reboot="  : Reboot"
sleep="󰒲  : Sleep"
restartBSPWM="  : Restart BSPWM"
restartSXHKD="  : Restart SXHKD | Shortcuts"


# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$restartBSPWM
$restartSXHKD
$sleep
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
                  -font "Symbols Nerd Font 12"\
                  -width "15"\
                  -lines 6\
                  -line-margin 43\
                  -line-padding 10\
                  -scrollbar-width "0" )

# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
    slock
elif [ "$selected_option" == "$logout" ]
then
    bspc quit
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    amixer set Master mute
    systemctl suspend
elif [ "$selected_option" == "$restartBSPWM" ]
then
    bspc wm -r
elif [ "$selected_option" == "$restartSXHKD" ]
then
    pkill -USR1 -x sxhkd
else
    echo "No match"
fi
