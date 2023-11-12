#!/bin/sh

BAT_PATH="/sys/class/power_supply/BAT0"
bat_lvl=$(cat "$BAT_PATH/capacity")
bat_stat=$(cat "$BAT_PATH/status")

case "$1" in
  "--level")
    printf "%s\n" "$bat_lvl"
    ;;
  "--status")
    printf "%s\n" "$bat_stat"
    ;;
  "--color")
    if [ "$bat_stat" = "Charging" -o "$bat_stat" = "Not charging" ]; then
      printf "batup\n"
    elif [ "$bat_stat" = "Discharging" ] && [ "$bat_lvl" -le 25 ]; then
      printf "batdownred\n"
    elif [ "$bat_stat" = "Discharging" ] && [ "$bat_lvl" -le 50 ]; then
      printf "batdown25\n"
    elif [ "$bat_stat" = "Discharging" ] && [ "$bat_lvl" -gt 50 ]; then
      printf "batdown50\n"
    else
      printf "batunknown\n"
    fi
    ;;
  *)
    printf "Invalid option\n"
    ;;
esac
