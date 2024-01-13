{ lib, config, ... }:
{
  imports = [
    ./zellij
    #./screen
    #./tmux
  ];

  options.programs.console.multiplexer = {
    zellij = {
      enable = lib.mkEnableOption "Enable zellij multiplexer";
    };
  };
}
