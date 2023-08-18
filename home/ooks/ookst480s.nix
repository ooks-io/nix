{ inputs, outputs, ... }:

{
  imports = [
    ./opt/nvim
    ./opt/shell
    ./opt/desktop/hyprland
    ./standard  
  ];

  colorscheme = inputs.nix-colors.colorSchemes.everforest;

  home.username = "ooks";
  home.homeDirectory = "/home/ooks";

  programs.home-manager.enable = true;
}
