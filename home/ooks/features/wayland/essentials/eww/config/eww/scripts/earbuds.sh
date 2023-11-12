#!/usr/bin/env bash

BUDS_STATUS=$(earbuds status -o json -q)

# Check if the earbuds are connected
IS_CONNECTED=$(echo $BUDS_STATUS | jq -r '.status // empty')
if [ "$IS_CONNECTED" == "error" ] || [ -z "$IS_CONNECTED" ]; then
    if [ "$1" = "--connection" ]; then
        echo " 󱡐 "
    fi
    exit 0
fi

LEFT=$(echo $BUDS_STATUS | jq -r '.payload.batt_left // empty')
RIGHT=$(echo $BUDS_STATUS | jq -r '.payload.batt_right // empty')

if [ "$(echo $BUDS_STATUS | jq -r '.payload.placement_left // empty')" == "3" ] && [ -n "$LEFT" ]; then
    LEFT="󱐋$LEFT"
fi

if [ "$(echo $BUDS_STATUS | jq -r '.payload.placement_right // empty')" == "3" ] && [ -n "$RIGHT" ]; then
    RIGHT="󱐋$RIGHT"
fi

case "$1" in
    "--left")
        [ -n "$LEFT" ] && echo -n "$LEFT"
        ;;
    "--right")
        [ -n "$RIGHT" ] && echo -n "$RIGHT"
        ;;
    "--connection")
        echo -n " 󱡏 "  
        ;;
esac
