{ pkgs, config, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = "set -g status-position top";
  };
}
