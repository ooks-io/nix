{ config, ... }:
let
  inherit (config) colorscheme;
  inherit (colorscheme) colors;
in

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "${colorscheme.slug}";
      themes = {
        "${colorscheme.slug}" = {
          fg = "#${colors.base05}";
          bg = "#${colors.base00}";
          black = "#${colors.base00}";
          red = "#${colors.base08}";
          green = "#${colors.base0B}";
          yellow = "#${colors.base0A}";
          blue = "#${colors.base0D}";
          magenta = "#${colors.base0E}";
          cyan = "#${colors.base0C}";
          white = "#${colors.base05}";
          orange = "#${colors.base09}";
        };
      };
    };
  };
#  home.sessionVariable = ZELLIJ_AUTO_ATTACH = "1";
}
