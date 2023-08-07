{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = [
  	pkgs.galaxy-buds-client
	];
}
