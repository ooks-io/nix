{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
    ./fish.nix
    ./locale.nix
    ./security.nix
    ./systemdboot.nix
    ./pipewire.nix
  # ./auto-upgrade.nix # still needs some work
    ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "openssl-1.1.1u"
      ];
    };
  };
    
    
  #hardware.enableRedistibutableFirmware = true;
  environment.enableAllTerminfo = true;

  }