{ config, lib, pkgs, ... }:

{
  imports = [
    ../../profiles
  ];

  activeProfiles = ["base"];
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    helix # or some other editor, e.g. nano or neovim
    git
    killall
    hostname
    man
    coreutils
  ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "23.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Pacific/Auckland";

  user = {
    userName = "ooks";
    home = "/data/data/com.termux.nix/files/ooks/home";
    shell = "${pkgs.fish}/bin/fish";
  };

  # Configure home-manager
  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    config = import ../../../home/user/ooks/ooksphone;
  };
}
