{ config, ... }:
let
  inherit (config) colorscheme;
in
{
  home.sessionVariables.COLORTERM = "truecolor";
  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.VISUAL = "hx";

  
  programs.helix = {
    enable = true;
    settings = {
      theme = colorscheme.slug;
      editor = {
        color-modes = true;
        middle-click-paste = false;
        line-number = "relative";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
        };
        lsp = {
          display-messages = true;
        };
      };
    };
    themes = import ./theme.nix { inherit colorscheme; };
  };
}
