#!/bin/bash
for monitor in $(xrandr -q | grep -w connected | awk '{print $1}'); do
	if [ $(xrandr -q | grep primary | awk '{print $1}') == $monitor ]; then
		echo "Start polybar-top-tray@$monitor"
		systemctl --user start polybar-top-tray@$monitor.service
	else
		echo "Start polybar-top@$monitor"
		systemctl --user start polybar-top@$monitor.service
	fi
	echo "Start polybar-bottom@$monitor"
	systemctl --user start polybar-bottom@$monitor.service
done
