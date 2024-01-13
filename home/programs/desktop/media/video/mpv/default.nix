{ lib, config, ... }:

let
  cfg = config.programs.desktop.media.video.mpv;
in
{
  config = {
    programs.mpv = lib.mkIf cfg.enable {
      enable = true;
    };
  };
}
