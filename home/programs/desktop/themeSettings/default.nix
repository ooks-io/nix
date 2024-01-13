{ lib, ... }:
{
  imports = [
    ./cursor.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
  ];

  # settings to be expanded on in the future
  options.programs.desktop.themeSettings = {
    enable = lib.mkEnableOption "Enable theme settings";
  };
}
