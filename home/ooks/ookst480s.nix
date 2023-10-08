{ inputs, outputs, ... }:

{
  imports = [
    ./opt/nvim
    ./opt/shell
    ./opt/desktop/hyprland
    ./standard  
  ];

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-soft;

}