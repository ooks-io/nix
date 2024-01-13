{ lib, ... }:
{
  imports = [
    ./starship
  ];

  options.programs.console.prompt = {
    starship = {
      enable = lib.mkEnableOption "Enable starship prompt";
    };
  };
}
