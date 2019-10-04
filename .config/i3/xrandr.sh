#!/bin/bash
set -euo pipefail

# Search all screen layout scripts and pipe it to rofi for selection
layout=$(find $HOME/.screenlayout/ -type f -printf "%f\n" | rofi -dmenu -p screenlayout)

if [[ $layout ]]; then
    # Execute selected layout
    $HOME/.screenlayout/$layout
    
    # Restart i3
    i3-msg restart
fi
