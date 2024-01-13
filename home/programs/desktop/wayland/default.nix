{ lib, ... }:
{
  imports = [
    ./bar
    ./lockscreen
    ./notification
    ./utility
    ./windowManager
    # ./launcher
  ];

  options.programs.desktop.wayland = {
    base = {
      enable = lib.mkEnableOption "Enable wayland specific utilities";
    };
  };
}
