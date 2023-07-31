{
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      hardware.url = "github:nixos/nixos-hardware";
      nix-colors.url = "github:misterio77/nix-colors";

      firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
      };

    };

    outputs = {   self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib // home-manager.lib;
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;

      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # X1 Carbon
        ooksx1 =  lib.nixosSystem {
          inherit system;
          modules = [ ./system/ooksx1 ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      homeConfigurations = {
        # X1 Carbon
        "ooks@ooksx1" = lib.homeManagerConfiguration {
          inherit system;
          modules = [ ./home/ooks/ooksx1.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };    
    };
}
