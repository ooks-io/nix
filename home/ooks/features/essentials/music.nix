{ config, pkgs, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  home.packages = with pkgs; [ 
    alsa-utils
    spotify-player
  ];
}
