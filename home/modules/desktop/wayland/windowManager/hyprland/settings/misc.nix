{ lib, config, ... }:

let
  cfg = config.homeModules.desktop.wayland.windowManager.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      enable_swallow = true;
      swallow_regex = "foot|nemo";

      focus_on_activate = true;
    };
  };
} 
