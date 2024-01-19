{ config, inputs, pkgs, ... }:

{
	imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t480s
		./hardware-configuration.nix
    ../../profiles
		# ../../modules
		];

    activeProfiles = ["base" "laptop"];

		systemModules.user = {
			ooks.enable = true;
			shell.fish.enable = true;
		};
  	
		networking = {
  		hostName = "ooks-t480"; 		
		};
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    };
}