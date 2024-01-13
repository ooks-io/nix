{ pkgs, config, ... }: {
  imports = [
    ./lf
    ./git.nix
    ./bash.nix
    ./fish.nix
    ./starship.nix
    ./nix-index.nix
    ./zellij.nix
  ];
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
    
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    lazygit # git uitlity
    comma # Install and run with ","
    tldr # Community maintained help pages
    progress
    killall
    gcc
    acpi

    # Nix tooling
    alejandra
  ];

  programs = {
    btop.enable = true;
    eza.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "base16";
        pager = "less -FR";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons -L 3 -T --color always {} | head -200'"
        "--exact"
      ];
      fileWidgetCommand = "rg --files";
      fileWidgetOptions = [
        "--preview 'bat --color=always {}'"
      ];
    };
  };
}
