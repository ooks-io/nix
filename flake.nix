{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nix-colors.url = "github:misterio77/nix-colors";
    };

    outputs = {  nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config = {
                allowUnfree = true;
            };
        };
    in
    {
        homeConfigurations = {
            ooks = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
                modules = [
                    ./home/ooks/home.nix 
                ];
            };
        };
        nixosConfigurations = {
            ooksthink = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./systems/laptop/laptop.nix
                ];
            };
            ooksdesk = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./systems/desktop/configuration.nix
                ];
            };
        };
    };
}
