



{ config, pkgs, ... }:

# Imports
# -------------------------------------------------------------------------------------------------

{
	imports =
		[ # Include the results of the hardware scan
		./hardware-configuration.nix
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

# Allow Unfree
# -------------------------------------------------------------------------------------------------

	nixpkgs.config.allowUnfree = true;

# Networking
# -------------------------------------------------------------------------------------------------

	networking = {
		hostName = "ooksthink"; # Define your hostname.
		networkmanager.enable = true;  # Easiest to use and most distros use this by default.
		};


# Time Zone
# -------------------------------------------------------------------------------------------------

	time.timeZone = "Pacific/Auckland";

# Localization
# -------------------------------------------------------------------------------------------------

	i18n.defaultLocale = "en_US.UTF-8";

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

	# services.printing.enable = true;

# Sound
# -------------------------------------------------------------------------------------------------

	sound.enable = false;
	hardware.pulseaudio.enable = false;

# Touchpad
# -------------------------------------------------------------------------------------------------

	# services.xserver.libinput.enable = true;

# User
# -------------------------------------------------------------------------------------------------

	users.users = {
		ooks = {
			isNormalUser = true;
			extraGroups = [ "wheel" ];
			shell = pkgs.fish;

# User Packages
# -------------------------------------------------------------------------------------------------

  			packages = with pkgs; [
  				firefox
  				tree
 				hyprland
 				kitty
    				];
  			};
		};

# System Environment
# -------------------------------------------------------------------------------------------------

	environment = {
		binsh = "${pkgs.dash}/bin/dash";
		shells = with pkgs; [ fish ];
		systemPackages = with pkgs; [
		#	Editor
		#	------
			neovim
		#	Utility
		#	------
			wget
			dash
			neofetch
			glib
			xdg-utils
			pciutils
			gdb
			killall
			jetbrains-mono
			cargo
			p7zip
			joshuto
			zip
			rar
			btop
			git
			libnotify
			dunst
			wl-clipboard
			wlr-randr
			wayland
			wayland-scanner
			wayland-utils
			egl-wayland
			wayland-protocols
			wev
			alsa-lib
			alsa-utils
			flac
			pulsemixer
			linux-firmware
			lxappearance
			pkgs.sway-contrib.grimshot
			flameshot
			grim
  			];
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
  	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
 		};   
	programs.fish = {
		enable = true;
		};

# Services
# -------------------------------------------------------------------------------------------------

	security.rtkit.enable = true;

	services = {
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};
		dbus.packages = [ pkgs.gcr ];
		getty.autologinUser = "ooks";
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

# Security
# -------------------------------------------------------------------------------------------------

	security.polkit.enable = true;
	security.sudo = {
		enable = true;
		extraConfig = ''
			ooks ALL=(ALL) NOPASSWD:ALL
			'';
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
