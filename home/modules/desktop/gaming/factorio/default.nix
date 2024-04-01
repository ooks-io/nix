{ lib, config, pkgs, ... }:

let
  cfg=config.homeModules.desktop.gaming.factorio;
in

{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ factorio ];
  };
}