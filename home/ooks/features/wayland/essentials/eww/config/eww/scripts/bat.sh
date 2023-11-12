#!/bin/sh

battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

case "$1" in
  "--percentage")
    echo "$battery_level"
    ;;
  "--color")
    if [ $battery_level -le 20 ]; then
        echo "progbarlow"
    elif [ $battery_level -le 50 ]; then
        echo "progbarmid"
    else
        echo "progbarhigh"
    fi
    ;;
  "--status")
    if [ "$battery_status" = "Charging" ]; then
        echo "Charging"
    elif [ "$battery_status" = "Discharging" ]; then
        echo "Discharging"
    else
        echo "we full"
    fi
    ;;
  *)
    echo "Invalid argument try --color, --percentage"
    ;;
esac
