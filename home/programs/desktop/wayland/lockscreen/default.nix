{ lib, ... }:
{

  imports = [
    #./gtkLock --- still needs to be implemented
    ./swaylock
  ];

  options.programs.desktop.wayland.lockscreen = {
    swaylock = {
      enable = lib.mkEnableOption "Enable Swaylock screen";
    };
  };
}

