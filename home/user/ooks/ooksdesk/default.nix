{ inputs, outputs, config, ... }:

{
  imports = [
    ../../../profile
  ];

  activeProfiles = ["base" "hyprland" "productivity"];

  home.sessionVariables.HN = "ooksdesk";

  homeModules.desktop.wayland.windowManager.hyprland.nvidia = true;
  
  monitors = [{
    name = "DP-1";
    width = 2560;
    height = 1440;
    refreshRate = 155;
    workspace = "1";
    primary = true;
  }];

  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-soft;
}

