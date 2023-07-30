{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "JetBrains Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrains" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
}
