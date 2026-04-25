#!/usr/bin/env bash

# source:
# https://codeberg.org/phmcc/fuzzel-scripts/src/branch/main/fuzzel-pwrmenu/fuzzel-pwrmenu

# Options for powermenu
LOCK="1.   Lock Screen"
LOGOUT="4.   Logout | Close Session"
MONITOR="3. 󰶐  Monitors Power Off"
SLEEP="5. 󰒲  Suspend | Sleep"
REBOOT="6.   Reboot Normal"
REBOOTHARD="7.   Reboot Hard (try Normal first)"
SHUTDOWN="8.   Shutdown | Power Off"
RESTARTWAYBAR="2.   Restart Waybar"

SELECTION="$(printf "$LOCK
$RESTARTWAYBAR
$MONITOR
$LOGOUT
$SLEEP
$REBOOT
$REBOOTHARD
$SHUTDOWN" | fuzzel --dmenu -l 8 -p "Power Menu: ")"

case $SELECTION in
    $LOCK)
        swaylock;;
    $LOGOUT)
        niri msg action quit;;
    $MONITOR)
        niri msg action power-off-monitors;;
    $SLEEP)
        systemctl suspend;;
    $REBOOT)
        systemctl reboot;;
    $REBOOTHARD)
        pkexec "echo b > /proc/sysrq-trigger";;
    $SHUTDOWN)
        systemctl poweroff;;
    $RESTARTWAYBAR)
        killall -SIGUSR2 waybar;;
esac

