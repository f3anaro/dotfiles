#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for monitor in $(xrandr -q | grep -w connected | awk '{print $1}'); do
    # Start top-bar with tray on primary screen
    if [ $(xrandr -q | grep primary | awk '{print $1}') == $monitor ]; then
        POLYBAR_MONITOR=$monitor polybar top-tray &
    else
        POLYBAR_MONITOR=$monitor polybar top &
    fi
    POLYBAR_MONITOR=$monitor polybar bottom &
done

# Terminate already running compton instances
killall -q compton

# Wait until compton have been shutdown
while pgrep -u $UID -x compton > /dev/null; do sleep 1; done

# Start compton compositor
compton --daemon
