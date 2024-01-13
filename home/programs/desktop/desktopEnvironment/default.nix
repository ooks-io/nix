{ lib, ... }
{
  import = [
    ./window-manager
    #./gnome -- still needs to be implemented
    #./kde -- still needs to implemented
    ./appearance
  ];

  options.programs.desktop.desktopEnvironment = {
    hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland window-manager";
    };
  };
}
