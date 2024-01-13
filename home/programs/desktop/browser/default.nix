{ lib, ... }:
{

  imports = [
    ./firefox
    #./chrome -- still needs to be implemented
    #./brave -- still needs tio be implemented
  ];

  options.programs.desktop.browser = {
    firefox = {
      enable = lib.mkEnableOption "Enable firefox browser";
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set Firefox as default browser";
      };
    };
  };
}
