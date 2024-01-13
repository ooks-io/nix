{ config, lib, ... }:
let
  cfg = config.programs.desktop.themeSettings;
in
{
  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "gtk";
      };
  };
}
