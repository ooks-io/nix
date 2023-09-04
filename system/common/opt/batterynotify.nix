{ config, lib, pkgs, ... }:

let
  conf = config.modules.battery-notify;
in {

  options.modules.battery-notify = with lib; {
    enable = mkEnableOption "battery-notify";
  };

  config = lib.mkIf conf.enable {
    systemd.user.services.battery-notify = {
      wantedBy = [ "graphical-session.target" ];
      script = ''

        batval=$(cat /sys/class/power_supply/BAT0/capacity)
        tempbatval="/tmp/bat_val_$batval"
      
        if [ ! -f "$tempbatval" ]; then
          case "$batval" in
            75|50|25|10|5)
              ${pkgs.libnotify}/bin/notify-send -a bat-notify "battery:" "$batval"
              touch "tempbatval"
              ;;
          esac
        fi
          
        for level in 75 50 25 10 5; do
          if [ "$batval" -gt "$level" ]; then
            rm -f "/tmp/bat_val_$level"
          fi
        done
      '';
          

    };
    

    systemd.user.timers.battery-notify = {
      wantedBy = [ "timers.target" ];
      after = [ "basic.target" ];
      requires = [ "battery-notify.service" ];
      partOf = [ "battery-notify.service" ];
      timerConfig = {
        OnBootSec = "1m";
        OnUnitActiveSec = "1m";
      };
    };
  };

}
