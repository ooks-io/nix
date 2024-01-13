{ lib, ... }:

{
  imports = [
    ./hyprland
  ];

  options.programs.desktop.wayland.windowManager = { 
    hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland window-manager";
    };
  };

}
