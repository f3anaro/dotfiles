#!/bin/bash
set -euo pipefail

# Search all autorandr profiles and pipe it to rofi for selection
profile=$(find ~/.config/autorandr/* -maxdepth 1 -type d -printf '%f\n' | rofi -dmenu -p autorandr)

if [[ $profile ]]; then
    autorandr --load $profile

    # Restart i3
    # i3-msg restart
    # ~/.config/polybar/launch.sh
fi
