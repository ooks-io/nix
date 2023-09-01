{ config, lib, pkgs, ... }:

let
  batteryNotifyScript = pkgs.writeShellScriptBin "battery-notify" ''
  #!/bin/sh

  BATTERY_PATH="/sys/class/power_supply/BAT0/capacity"
  NOTIFIED_PATH="/tmp/battery_notified"

  if [ ! -f $BATTERY_PATH ]; then
      echo "Battery not found!"
      exit 1
  fi

  BATTERY_PERCENT=$(cat $BATTERY_PATH)

  notify_battery() {
      level="$1"
      icon="$2"
      notify-send -a bat-notify $icon $level%"
  }

  if [ ! -f $NOTIFIED_PATH ]; then
      touch $NOTIFIED_PATH
      echo "100" > $NOTIFIED_PATH
  fi

  LAST_NOTIFIED=$(cat $NOTIFIED_PATH)

  case $BATTERY_PERCENT in
      75)
          [ "$LAST_NOTIFIED" -gt "75" ] && notify_battery "75" "" && echo "75" > $NOTIFIED_PATH
          ;;
      50)
          [ "$LAST_NOTIFIED" -gt "50" ] && notify_battery "50" "" && echo "50" > $NOTIFIED_PATH
          ;;
      25)
          [ "$LAST_NOTIFIED" -gt "25" ] && notify_battery "25" "" && echo "25" > $NOTIFIED_PATH
          ;;
      10)
          [ "$LAST_NOTIFIED" -gt "10" ] && notify_battery "10" "" && echo "10" > $NOTIFIED_PATH
          ;;
      5)
          [ "$LAST_NOTIFIED" -gt "5" ] && notify_battery "5" "" && echo "5" > $NOTIFIED_PATH
          ;;
  esac
     '';
in
    
{
  options = {
    services.battery-notify.enable = lib.mkEnableOption "Battery Notification Service";
  };

  config = { 
    services.battery-notify.enable = true;
  };
  
  config = lib.mkIf config.services.battery-notify.enable {
    
    systemd.user.services.battery-notify = {
      description = "Battery Notification Service";
      script = "${batteryNotifyScript}/bin/battery-notify";
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
    };

    systemd.user.timers.battery-notify = {
      description = "Timer for the Battery Notification Service";
      wantedBy = [ "timers.target" ];
      after = [ "network.target" ];
      requires = [ "battery-notify.service" ];
      partOf = [ "battery-notify.service" ];
      timerConfig = {
        OnBootSec = "1m";
        OnUnitActiveSec = "1m";
      };
    };

  
  };

}

