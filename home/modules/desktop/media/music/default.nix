{ lib, ... }:
{
  imports = [
    #./spotify --- still needs to be implemented
    ./tui
  ];

  options.homeModules.desktop.media.music = {
    tui = {
      enable = lib.mkEnableOption "Enable tui music";
    };
    spotify = {
      enable = lib.mkEnableOption "Enable spotify";
    };
  };
}
