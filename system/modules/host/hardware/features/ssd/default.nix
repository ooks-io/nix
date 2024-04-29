{ lib, config, ... }:

let
  features = config.systemModules.host.hardware.ssd;
  inherit (lib) mkIf;
  inherit (builtins) elem;
in

{
  config = mkIf (elem "ssd" features) {
    services.fstrim = {
      enable = true;
    };
    # only run fstrim while connected on AC
    systemd.services.fstrim = {
      unitConfig.ConditionACPower = true;
      serviceConfig = {
        Nice = 19;
        IOSchedulingClass = "idle";
      };
    }; 
  };
}