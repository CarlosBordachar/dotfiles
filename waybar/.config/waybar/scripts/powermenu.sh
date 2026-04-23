#!/usr/bin/env bash

show_help() {
    echo "Usage:"
    echo " $0 [OPTIONS]"
    echo
    echo "Invoke wlogout or quit niri action"
    echo
    echo "Options:"
    echo "  -m           Power-off monitors"
    echo "  -r           Refresh waybar"
    echo "  -h, --help   Show help"
    echo
    echo "e.g.:"
    echo "  $0      # wlogout"
    echo "  $0 -m   # power-off monitors"
    echo "  $0 -r   # refresh waybar"
    exit 1
}

HAS_WLOGOUT=0
command -v wlogout >/dev/null 2>&1 && HAS_WLOGOUT=1

case "$1" in
    "")
        if [ $HAS_WLOGOUT = 1 ]; then
            wlogout
        else
            niri msg action quit
        fi
        ;;
    -m|m)
        niri msg action power-off-monitors
        ;;
    -r|r)
        killall -SIGUSR2 waybar
        ;;
    --help|-h)
        show_help
        ;;
    *)
        echo "ERROR: invalid parameter: '$1'" >&2
        show_help
        ;;
esac
