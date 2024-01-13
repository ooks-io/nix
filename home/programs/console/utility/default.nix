{ lib, ... }:
{
  imports = [
    ./nixIndex
    ./git
    ./tools
  ];

  options.programs.console.utility = {
    nixIndex = {
      enable = lib.mkEnableOption "Enable nixIndex configuration";
    };
    git = {
      enable = lib.mkEnableOption "Enable git + tools";
    };
    tools = {
      enable = lib.mkEnableOption "Enable various console tools";
    };
  };
}
