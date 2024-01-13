{ lib, ... }:

{

  imports = [
    ./foot
    ./kitty
  ];

  options.programs.desktop.terminal = {
    foot = {
      enable = lib.mkEnableOption "Enable foot terminal";
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set foot as default terminal in environment variables";
      };
    };
    kitty = {
      enable = lib.mkEnableOption "Enable kitty terminal";
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set kitty as default terminal in environment variables";
      };
    };
  };
}
