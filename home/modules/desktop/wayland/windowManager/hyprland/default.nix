{ lib, config, pkgs, inputs, ... }: 
let
  cfg = config.homeModules.desktop.wayland.windowManager.hyprland;
  inherit (import ./pkgs {inherit pkgs;}) hyprbrightness hyprvolume;
  inherit (inputs.ooks-scripts.packages.${pkgs.system}) powermenu zellijmenu;
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./settings
    ./extras
  ];

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.inputs.hyprland.hyprland ];
    };

    home.packages = [
      pkgs.hyprpicker
      hyprvolume
      hyprbrightness

      # Personal scripts
      powermenu
      zellijmenu #TODO: only add if zellij enabled
      ];
    
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
