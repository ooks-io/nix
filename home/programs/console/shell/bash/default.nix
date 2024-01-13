{ config, lib, ... }:
let
  cfg = config.programs.console.shell.bash;
in
{
  config = lib.mkIf cfg.enable {
    programs.bash.enable = true;
  };
}
