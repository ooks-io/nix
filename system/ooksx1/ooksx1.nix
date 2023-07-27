



{ config, pkgs, ... }:

# Imports
# -------------------------------------------------------------------------------------------------

{
	imports = [
    inputs.hardware.nixosModules.common-pc-ssd

		./hardware-configuration.nix
    
    ../common/user/ooks
    ../common/global/


		];

# Bootloader
# -------------------------------------------------------------------------------------------------

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;


# Nix Settings
# -------------------------------------------------------------------------------------------------

	nix = {
		settings = {
			auto-optimise-store = true;
			experimental-features = "nix-command flakes";
			};
		

# Garbage Collection
# -------------------------------------------------------------------------------------------------

	gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 2d";
		};
	};

# System Architecture
# -------------------------------------------------------------------------------------------------


	nixpkgs.system = "x86_64-linux";


# Hostname and networking
# -------------------------------------------------------------------------------------------------

	networking = {
		hostName = "ooksthink"; 		
    networkmanager.enable = true;
		};


# X Server
# -------------------------------------------------------------------------------------------------

	services.xserver = {
		 enable = true;
		 displayManager = {
		 	defaultSession = null;
			startx.enable = true;
			};
	# displayManager.gdm = { 
	# enable = true;
	# wayland = true;
	# };
};

# X11 Keymap
# -------------------------------------------------------------------------------------------------

	# services.xserver.layout = "us";
	# services.xserver.xkbOptions = "eurosign:e,caps:escape";

# Printing
# -------------------------------------------------------------------------------------------------

  services.printing.enable = true;

# Sound
# -------------------------------------------------------------------------------------------------

	sound.enable = false;
	hardware.pulseaudio.enable = false;

# Touchpad
# -------------------------------------------------------------------------------------------------

	# services.xserver.libinput.enable = true;

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

# Fonts
# -------------------------------------------------------------------------------------------------

fonts.fonts = with pkgs; [
	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];

# Programs
# -------------------------------------------------------------------------------------------------

	programs.mtr.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
 		};

# Services
# -------------------------------------------------------------------------------------------------

	services = {
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

	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
				};
			};
		};

# D-Bus
# -------------------------------------------------------------------------------------------------

	services.dbus.enable = true;

# Firewall
# -------------------------------------------------------------------------------------------------

	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

# System Version
# -------------------------------------------------------------------------------------------------

	system = {
		autoUpgrade = {
			enable = false;
			channel = "https://nixos.org/channels/nix-unstable";
			};
		stateVersion = "23.11";
		copySystemConfiguration = false;
	};
}
