#!/usr/bin/env bash

# Invoke wlogout or fuzzel-powermenu script or niri action quit.

HAS_WLOGOUT=0
command -v wlogout >/dev/null 2>&1 && HAS_WLOGOUT=1

HAS_FUZZEL=0
command -v fuzzel >/dev/null 2>&1 && HAS_FUZZEL=1

if [ $HAS_WLOGOUT = 1 ]; then
    wlogout
elif [ $HAS_FUZZEL = 1 ]; then
    # source ./fuzzel-powermenu.sh
    # . ${0%/*}/fuzzel-powermenu.sh
    # bash_source is better than $0 for sourced scripts
    #. ${BASH_SOURCE%/*}/fuzzel-powermenu.sh
    ~/.config/scripts/fuzzel-powermenu.sh
else
    niri msg action quit
fi
