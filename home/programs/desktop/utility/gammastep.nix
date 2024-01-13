{ lib, config, ... }:
{
  services.gammastep = lib.mkif config.programs.desktop.windowManager.hyprland.enable {
    enable = true;
    provider = "geoclue2";
    temperature = {
      day = 6000;
      night = 4600;
    };
    settings = {
      general.adjustment-method = "wayland";
    };
  };
}
