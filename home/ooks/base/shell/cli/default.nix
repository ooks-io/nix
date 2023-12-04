{ pkgs, config, ... }: {
  imports = [
    ./lf
    ./fzf.nix
    ./git.nix
    ./bash.nix
    ./fish.nix
    ./pfetch.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    bc # Calculator
    
    # file utility
    duf
    du-dus
    fd
    ripgrep

    # archive
    zip
    uzip
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
    tmux # Terminal multiplexer
    progress
    killall
    gcc
    acpi
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
    skim = {
      enable = true;
      enableFishIntergration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'ea --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    }
  };
}
