{ lib, ... }:
{
  imports = [
    ./imv
  ];

  options.programs.desktop.media.image = {
    imv = {
      enable = lib.mkEnableOption "Enable imv image viewer";
    };
  };

}
