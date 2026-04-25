#!/usr/bin/env bash

# Invoke wlogout or fuzzel-powermenu script or niri action quit.

HAS_WLOGOUT=0
command -v wlogout >/dev/null 2>&1 && HAS_WLOGOUT=1

HAS_FUZZEL=0
command -v fuzzel >/dev/null 2>&1 && HAS_FUZZEL=1

if [ $HAS_WLOGOUT = 1 ]; then
    # execute wlogout.sh script if exists (custom invoke) or wlogout plain.
    #if [ -f ~/.config/wlogout/wlogout.sh ]; then
    #    . ~/.config/wlogout/wlogout.sh
    #else
    #    wlogout
    #fi
    [ -f ~/.config/wlogout/wlogout.sh ] && . ~/.config/wlogout/wlogout.sh || wlogout
elif [ $HAS_FUZZEL = 1 ]; then
    # source ./fuzzel-powermenu.sh
    # . ${0%/*}/fuzzel-powermenu.sh
    # bash_source is better than $0 for sourced scripts
    #. ${BASH_SOURCE%/*}/fuzzel-powermenu.sh
    ~/.config/scripts/fuzzel-powermenu.sh
else
    niri msg action quit
fi
