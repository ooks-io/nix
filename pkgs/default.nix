{ pkgs ? (import ../nixpkgs.nix) { } }: {
  
  live-buds-cli = pkgs.callPackage ./live-buds-cli { };

}
