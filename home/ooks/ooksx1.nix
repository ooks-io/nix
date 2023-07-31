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

  home.stateVersion = "23.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
