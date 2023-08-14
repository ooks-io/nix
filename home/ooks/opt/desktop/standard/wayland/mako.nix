{ config, ... }:
let inherit (config.colorscheme) colors kind;
in {
  services.mako = {
    enable = true;
    iconPath =
      if kind == "dark" then
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
      else
        "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10,10";
    anchor = "top-right";
    width = 300;
    height = 100;
    borderSize = 2;
    defaultTimeout = 3000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base0C}dd";
    textColor = "#${colors.base05}dd";
  };
}
