{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  
  # services.blueman.enable = true;
  
  environment.systemPackages = with pkgs; [
  	galaxy-buds-client
    live-buds-cli
	  bluetuith
	];
}
