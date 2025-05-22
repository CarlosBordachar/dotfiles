#!/bin/bash

# Change Wallpaper. 
# Parameter 1: Image's ABSOLUTE path.

if [ -z "$1" ]; then
    echo "You must specify an image. Ex: chwall ~/path/to/image.jpg"
else
    ln -sf "$1" ~/.config/wallpaper.jpg && xwallpaper --stretch ~/.config/wallpaper.jpg
fi
