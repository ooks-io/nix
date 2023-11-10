{ inputs, outputs, ... }:

{
  imports = [
    ./features/wayland/window-manager/hyprland
    ./base  
  ];

  monitors = [{
    name = "eDP-1";
    width = 720;
    height = 1280;
    workspace = "1";
    primary = true;
    transform = 3;
  }];
  
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-soft;

}