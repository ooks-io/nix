{ config, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      setting = {
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        }
      }
    };
  };
}
