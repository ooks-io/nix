{ inputs, outputs, ... }:

{
  imports = [
    ./opt/desktop/hyprland
    ./base  
  ];

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-soft;

}