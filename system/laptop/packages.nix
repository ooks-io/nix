
{ pkgs, ... }
{
# System Packages
# -------------------------------------------------------------------------------------------------

	environment = { 
		binsh = with pkgs; [ fish ]
		systemPackages = with pkgs; [
			# Editor
			neovim
			# Utility
			wget
			neofetch
			glib
			xdg-utils
			killall
			zip
			rar
			btop
			p7zip
			git
			pciutils
			gdb
			dash
			curl
			# Programming
			cargo
			# Fonts
			jetbrains-mono
			# File browsers
			ranger
			joshuto
			# Wayland
			wayland
			wayland-scanner
			wayland-utils
			egl-wayland
			wayland-protocols 
			wev # Wayland window debugger
			wl-clipboard # Wayland clipboard
			wlr-randr
			# Firmware
			linux-firmware
			# Audio
			alsa-lib
		alsa-utils
			flac
			pulsemixer
			# Appearance
			lxappearance
			# Screenshot
			pkgs.sway-contrib.grimshot
			flameshot
			grim
			# Notification
			dunst
			libnotify
			];
	};

# Programs
# -------------------------------------------------------------------------------------------------

	programs.mtr.enable = true
	programs.gnupg.agent = {
		enable = true;
		enabeSSHSupport = true;
		};
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
		};
	programs.fish = {
		enable = true
		};


