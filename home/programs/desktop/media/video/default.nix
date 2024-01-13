{ lib, ... }:
{
  imports = [
    ./youtube
    ./jellyfin
    ./mpv
  ];
  
  options.programs.desktop.media.video = {
    mpv = {
      enable = lib.mkEnableOption "Enable mpv video player";
    };
    youtube = {
      enable = lib.mkEnableOption "Enable youtube tui player";
    };
    jellyfin = {
      enable = lib.mkEnableOption "Enable jellyifn media player";
    };
  };
}
