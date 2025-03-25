#!/bin/bash

# Author: Pushpak Dagade

# This script automatically detects if an external monitor is connected,
# and if so, expands my screen with the monitor on the left and my
# laptop screen on the right. If my laptop lid is shut & an external
# monitor is connected, this script uses only the external monitor as
# the display.
#
# TODOS:
# When external monitor is connected, automatically find out its maximum
#  supported resolution and set it.
# As of now, it is hard coded to be 1600x900

export DISPLAY=:0   ## notify-send involves GUI

#notify-send "testing as user $USER"
xrandr | grep HDMI | grep " connected "
if [ $? -eq 0 ]; then
  # External monitor is connected

	# If laptop lid open: Turn on both screens
	# If laptop lid closed: Turn only external monitor screen
	grep -q closed /proc/acpi/button/lid/LID0/state
	if [ $? = 0 ]
	then
			# lid is closed
			xrandr --output eDP-1 --mode 1366x768 --panning 1600x900 --scale 1.1713x1 --output HDMI-1 --off
			notify-send 'Laptop lid state: Closed' 'Only external monitor turned ON' -i info
	else
			# lid is open
      xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
      xrandr --addmode eDP-1 "1600x900_60.00"
			xrandr --output eDP-1 --mode "1600x900_60.00" --output HDMI-1 --auto --primary --left-of eDP-1
			notify-send 'Laptop lid state: Open' 'Both screens are now turned ON. \nLEFT :\tExternal Monitor \nRIGHT :\tLaptop Screen' -i info

	fi

    if [ $? -ne 0 ]; then
        # Something went wrong. Autoconfigure the internal monitor and disable the external one
        #xrandr --output eDP-1 --mode 1366x768 --panning 1600x900 --scale 1.1713x1 --output HDMI-1 --off
        xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
        xrandr --addmode eDP-1 "1600x900_60.00"
        xrandr --output eDP-1 --mode "1600x900_60.00" --output HDMI-1 --off
    fi
else
    # External monitor is not connected
    notify-send 'No external monitor connected' 'Only laptop screen turned ON.' -i info
    #xrandr --output eDP-1 --mode 1366x768 --panning 1600x900 --scale 1.1713x1 --output HDMI-1 --off
    #xrandr --newmode "1600x900_60.00"  119.00  1600 1696 1864 2128  900 901 904 932  -HSync +Vsync
    xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
    xrandr --addmode eDP-1 "1600x900_60.00"
    xrandr --output eDP-1 --mode "1600x900_60.00" --output HDMI-1 --off
fi
