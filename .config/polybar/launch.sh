#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for MONITOR in $(xrandr -q | grep -w connected | cut -d" " -f1); do
    POLYBAR_MONITOR=$MONITOR polybar top &
    POLYBAR_MONITOR=$MONITOR polybar bottom &
done

# Terminate already running compton instances
killall -q compton

# Wait until compton have been shutdown
while pgrep -u $UID -x compton > /dev/null; do sleep 1; done

# Start compton compositor
compton --daemon
