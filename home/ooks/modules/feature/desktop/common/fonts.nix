{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrains" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
