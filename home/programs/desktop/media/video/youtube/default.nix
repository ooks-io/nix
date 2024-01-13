{ lib, config, pkgs, ...}:
let
  cfg = config.programs.desktop.media.video.youtube;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ youtube-tui ];
    programs.yt-dlp = {
      enable = true;
    };
  };
}
