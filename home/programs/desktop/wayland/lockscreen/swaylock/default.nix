{ config, lib, ... }:

let
  inherit (config.colorscheme) colors;
  cfg = config.programs.desktop.wayland.lockscreen.swaylock;
in
{
  config = {
    programs.swaylock = lib.mkIf cfg.enable {
      enable = true;
      settings = {
        font = config.fontProfiles.monospace.family;
        color = "#${colors.base01}";
        ring-color = "#${colors.base02}";
        inside-wrong-color = "#${colors.base08}";
        ring-wrong-color = "#${colors.base08}";
        key-hl-color = "#${colors.base0B}";
        bs-hl-color = "#${colors.base08}";
        ring-ver-color = "#${colors.base09}";
        inside-ver-color = "#${colors.base09}";
        inside-color = "#${colors.base01}";
        text-color = "#${colors.base07}";
        text-clear-color = "#${colors.base01}";
        text-ver-color = "#${colors.base01}";
        text-wrong-color = "#${colors.base01}";
        text-caps-lock-color = "#${colors.base07}";
        inside-clear-color = "#${colors.base0C}";
        ring-clear-color = "#${colors.base0C}";
        inside-caps-lock-color = "#${colors.base09}";
        ring-caps-lock-color = "#${colors.base02}";
        separator-color = "#${colors.base02}";
      };
    };
  };
}