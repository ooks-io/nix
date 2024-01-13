{ inputs, outputs, ... }:

{
  imports = [
    ./features/wayland/window-manager/hyprland
    ./base
  ];

  colorscheme = inputs.nix-colors.colorSchemes.everforest;

  home.username = "ooks";
  home.homeDirectory = "/home/ooks";

  programs.home-manager.enable = true;
}
