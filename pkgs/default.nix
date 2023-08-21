{ pkgs ? (import ../nixpkgs.nix) { } }: {
  
  nvchad = pkgs.callPackage ./nvchad { };

}
