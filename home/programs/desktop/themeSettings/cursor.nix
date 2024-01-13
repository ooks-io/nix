{ pkgs, lib, config, ... }: 
let
  cfg = config.programs.desktop.themeSettings;
in

{
  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
