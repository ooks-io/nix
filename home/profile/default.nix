{ lib, config, ... }:

let
  profileEnabler = let
    reducer = l: r: {"${r}".enable = true;} // l;
  in
    builtins.foldl' reducer {} config.activeProfiles;
in
{
  imports = [
    ./base
    ./hyprland
    #./creative
  ];

  options = {
    activeProfiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    
    profiles = {
      base = {
        enable = lib.mkEnableOption "Enable the base profile";
      };
      hyprland = {
        enable = lib.mkEnableOption "Enable the hyprland profile";
      };
    };
  };
  
  config.profiles = profileEnabler;
}
