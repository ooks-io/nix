{ pkgs ? (import ../nixpkgs.nix) { } }: {
  # example = pkgs.callPackage ./example { };
  nvchad = pkgs.callPackage ./nvchad { };
}
