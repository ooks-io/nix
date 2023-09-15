{ pkgs ? import <nixpkgs> {} }: rec {
  
  live-buds-cli = pkgs.callPackage ./live-buds-cli { };
}
