{ pkgs, ... }:

{
  home.package = with pkgs; [
    helix
  ]
}
