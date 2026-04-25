#!/usr/bin/env bash

show_help() {
    echo "Usage:"
    echo " $0 [OPTIONS]"
    echo
    echo "Invoke powermenu script at ~/.config/scripts"
    echo
    echo "Options:"
    echo "  -m           Power-off monitors"
    echo "  -r           Refresh waybar"
    echo "  -h, --help   Show help"
    echo
    echo "e.g.:"
    echo "  $0      # ~/.config/scripts/powermenu.sh"
    echo "  $0 -m   # power-off monitors"
    echo "  $0 -r   # refresh waybar"
    exit 1
}

case "$1" in
    "")
        ~/.config/scripts/powermenu.sh
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
