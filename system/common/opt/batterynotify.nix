{ config, pkgs, lib, ... }:

# Regularly check the battery status and send a notification when it discharges
# below certain thresholds.
# Implemented by calling the `acpi` program regularly. This is the simpler and
# safer approach because the battery might not send discharging events.
# author: github:Julow

let conf = config.modules.battery-notify;

in {
  options.modules.battery-notify = with lib; {
    enable = mkEnableOption "battery-notify";
  };

  config = lib.mkIf conf.enable {
    # Regularly check battery status
    systemd.user.services.battery-notify = {
      wantedBy = [ "graphical-session.target" ];
      script = ''
        prev_val=100
        check () { [[ $1 -ge $val ]] && [[ $1 -lt $prev_val ]]; }
        get_battery_glyph() {
          local val="$1"
          if [[ "$val" -le 10 ]]; then
              echo ""  # or echo -e "\uf244" if using the Unicode code
          elif [[ "$val" -le 25 ]]; then
              echo ""
          elif [[ "$val" -le 50 ]]; then
              echo ""
          elif [[ "$val" -le 75 ]]; then
              echo ""
          else
              echo ""
          fi
        }
        
        notify () {
          glyph=$(get_battery_glyph $val)
          ${pkgs.libnotify}/bin/notify-send -a bat-notify "$glyph   $val%"
        }
        while true; do
          IFS=: read _ bat0 < <(${pkgs.acpi}/bin/acpi -b)
          IFS=\ , read status val remaining <<<"$bat0"
          val=''${val%\%}
          if [[ $status = Discharging ]]; then
            echo "$val%, $remaining"
            if check 75 || check 50 ||check 30 || check 25 || check 20; then notify
            elif check 15 || [[ $val -le 10 ]]; then notify -u critical
            fi
          fi
          prev_val=$val
          # Sleep longer when battery is high to save CPU
          if [[ $val -gt 30 ]]; then sleep 10m; elif [[ $val -ge 20 ]]; then sleep 5m; else sleep 1m; fi
        done
      '';
    };

  };
}