{ lib, config, ... }:
let
  cfg = config.programs.desktop.media.image.imv;
in
{
  config = lib.mkIf cfg.enable {
    programs = {
      imv = {
        enable = true;
      };
    };
  };
}
