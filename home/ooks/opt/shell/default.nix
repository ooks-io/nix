{ pkgs, ... }: {
  imports = [
    ./bat.nix
    ./git.nix
    ./bash.nix
    ./fish.nix
    ./pfetch.nix
    ./starship.nix
    ./joshuto
  ];
  home.packages = with pkgs; [
    bc # Calculator
    ncdu # disk util
    exa # ls
    fd # find
    ripgrep # Better grep
    httpie # Better curl
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    nix-inspect # See which pkgs are in your PATH
    comma # Install and run with ","
  ];
}
