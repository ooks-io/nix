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
      
      hyprwm-contrib = {
        url = "github:hyprwm/contrib";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    
      hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;

      homeManagerModules = import ./modules/home-manager;

      #overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        # X1 Carbon
        ooksx1 =  lib.nixosSystem {
          modules = [ ./system/ooksx1/ooksx1.nix ];
          specialArgs = { inherit inputs outputs; };
        };
        # T480s
        ookst480s =  lib.nixosSystem {
          modules = [ ./system/ookst480s/ookst480s.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      homeConfigurations = {
        # X1 Carbon
        "ooks@ooksx1" = lib.homeManagerConfiguration {
          modules = [ ./home/ooks/ooksx1.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # T480s
        "ooks@ookst480s" = lib.homeManagerConfiguration {
          modules = [ ./home/ooks/ookst480s.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
      };    
    };
  };
}
