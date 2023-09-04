



{ config, inputs, pkgs, ... }:

# Imports
# -------------------------------------------------------------------------------------------------

{
	imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t480s

		./hardware-configuration.nix
    
    ../common/user/ooks
    ../common/global
    ../common/opt/bluetooth.nix
    ../common/opt/batterynotify.nix

		];

# Hostname and networking
# -------------------------------------------------------------------------------------------------

	networking = {
		hostName = "ookst480s"; 		
    networkmanager.enable = true;
		};


# Printing
# -------------------------------------------------------------------------------------------------

  services.printing.enable = true;

# Kernel
# ------------------------------------------------------------------------------------------------

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };


# Laptop Programs
# -------------------------------------------------------------------------------------------------

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

# XDG Portal
# ------------------------------------------------------------------------------------------------

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  
  hardware = {
    opengl = {
      enable = true;
    };
  };

# gnupg
# -------------------------------------------------------------------------------------------------

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
 	};

# Services
# -------------------------------------------------------------------------------------------------

  services = {
    logind = {
      lidSwitch = "suspend";
    };
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
	  governor = "powersave";
	  turbo = "never";
        };
        charger = {
	  governor = "performance";
	  turbo = "auto";
        };
      };
    };
  };	

# Battery notification
# -------------------------------------------------------------------------------------------------

  modules.battery-notify.enable = true;
# System Version
# -------------------------------------------------------------------------------------------------

	system = {
		autoUpgrade = {
			enable = false;
			channel = "https://nixos.org/channels/nix-unstable";
			};
		stateVersion = "22.05";
		copySystemConfiguration = false;
	};
}
