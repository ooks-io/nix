{ lib, config, pkgs, ... }: {
  imports = [
    ../../essentials #import essential wayland specific programs
    ../../../essentials #import essential programs
    #./tty-init.nix
    ./binds.nix #hyprland keybindings
    ./environment-variables.nix #hyprland environment variables
    ];


  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.grimblast
    hyprpicker
    ];
    
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.inputs.hyprland.hyprland;
        systemd = {
          enable = true;
          extraCommands = lib.mkBefore [
            "systemctl --user stop graphical-session.target"
            "systemctl --user start hyprland-session.target"
          ];
        };
    settings = {
      general = {
        gaps_in = 10;
        gaps_out = 10;
        border_size = 2;
        cursor_inactive_timeout = 4;
        "col.active_border" = "0xff${config.colorscheme.colors.base05}";
        "col.inactive_border" = "0xff${config.colorscheme.colors.base02}";
      };
      group = {
        "col.border_active" = "0xff${config.colorscheme.colors.base0B}";
        "col.border_inactive" = "0xff${config.colorscheme.colors.base04}";
      };
      input = {
        kb_layout = "us";
        touchpad.disable_while_typing = false;
      };
      dwindle.split_width_multiplier = 1.35;
      misc = {
        vfr = "true";
        disable_hyprland_logo = "true";
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        rounding = 0;
        blur = {
          enabled = false;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
        "col.shadow" = "0x44000000";
        "col.shadow_inactive" = "0x66000000";
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.11, 0, 0.5, 0"
          "easeout,0.5, 1, 0.89, 1"
          "easeinback,0.36, 0, 0.66, -0.56"
          "easeoutback,0.34, 1.56, 0.64, 1"
        ];

        animation = [
          "windowsIn,1,3,easeoutback,slide"
          "windowsOut,1,3,easeinback,slide"
          "windowsMove,1,3,easeoutback"
          "workspaces,1,2,easeoutback,slide"
          "fadeIn,1,3,easeout"
          "fadeOut,1,3,easein"
          "fadeSwitch,1,3,easeout"
          "fadeShadow,1,3,easeout"
          "fadeDim,1,3,easeout"
          "border,1,3,easeout"
        ];
      };

      windowrulev2 = [
        "float,move 191 15,size 924 396,class:(1Password)"
      ];
	
      monitor = lib.concatMap (m: let
        resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
        position = "${toString m.x}x${toString m.y}";
        basicConfig = "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}";
      in
        [ basicConfig ] ++ (if m.transform != 0 then ["${m.name},transform,${toString m.transform}"] else [])
      ) (config.monitors);

      exec = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${pkgs.swaybg}/bin/swaybg -i ~/.dotfiles/nix/walls/gruvbox/gruvbox-blank.png --mode fill"
      ];
      
      exec-once = 
        #let
        #eww = "${pkgs.eww-wayland}/bin/eww";
        #in 
        [
	        "${pkgs._1password-gui}/bin/1password --silent"
         # "${eww} daemon & ${eww} open bar & ${eww} open window-clock & ${eww} open window-battery & ${eww} open window-earbuds"
          "${pkgs.live-buds-cli}/bin/earbuds -d"
          "eww daemon && eww open bar"
          "eww open-many window-clock window-battery window-earbuds"
      ];
    };
  };
}
