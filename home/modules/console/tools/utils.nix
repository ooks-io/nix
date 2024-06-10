{ pkgs, lib, config, ... }:
let
  cfg = config.ooknet.console.utility.tools;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bc # Calculator
    
      # file utility
      duf
      du-dust
      fd
      ripgrep

      # archive
      zip
      unzip
      unrar
    
      # file transfer
      wget
      httpie # Better curl

      # resource manager
      powertop

      #shell scripting
      gum
      # audio ctrl
      pamixer
          
      diffsitter # Better diff
      jq # JSON pretty printer and manipulator
      comma # Install and run with ","
      tldr # Community maintained help pages
      progress
      killall
      acpi

      # Notifications
      libnotify

      # Nix tooling
      alejandra
    ];
  };
}