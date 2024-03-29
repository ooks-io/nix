{ lib, config, ... }:
let
  cfg = config.homeModules.desktop.wayland.windowManager.hyprland;
in
{
  config = {
    wayland.windowManager.hyprland.settings = lib.mkIf cfg.enable {
      windowrulev2 = [
        "float,move 191 15,size 924 396,class:(1Password)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "workspace 4, title:Vesktop"

        # Floating BTOP
        "float,title:^(BTOP)$"
        "size 85%,title:^(BTOP)$"
        "pin,title:^(BTOP)$"
        "center,title:^(BTOP)$"
        "stayfocused,title:^(BTOP)$"
        
        # 1Password
        "stayfocused,title:^(1Password)$"

        # Tearing
        "immediate, title:^(TEKKEN™8)$" 
      ];
    };
  };
}
