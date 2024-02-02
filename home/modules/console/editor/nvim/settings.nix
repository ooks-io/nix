{ config, lib, ... }:

let
  inherit (config.colorscheme) colors;
  cfg = config.homeModules.console.editor.nvim;
in

{
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      options = {
        relativenumber = true;
        number = true;
        hidden = true;
        mouse = "a";
        mousemodel = "extend";
        undofile = true;
        swapfile = false;
        incsearch = true;
        ignorecase = true;
        smartcase = true;
        fileencoding = "utf-8";
        termguicolors = true;
        autoindent = true;
        shiftwidth = 2;
        smartindent = true;
        expandtab = true;
        updatetime = 100;
      };

      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      colorschemes.base16 = {
        enable = true;
        colorscheme = config.colorscheme.slug;
        customColorScheme = {
          base00 = "#${colors.base00}";
          base01 = "#${colors.base01}";
          base02 = "#${colors.base02}";
          base03 = "#${colors.base03}";
          base04 = "#${colors.base04}";
          base05 = "#${colors.base05}";
          base06 = "#${colors.base06}";
          base07 = "#${colors.base07}";
          base08 = "#${colors.base08}";
          base09 = "#${colors.base09}";
          base0A = "#${colors.base0A}";
          base0B = "#${colors.base0B}";
          base0C = "#${colors.base0C}";
          base0D = "#${colors.base0D}";
          base0E = "#${colors.base0E}";
          base0F = "#${colors.base0F}";
        };
      };
    };
  };
}
