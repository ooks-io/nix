{ pkgs, ... }:
{
  # Neovim
  programs.neovim.enable = true;

  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  home.sessionVariables.EDITOR = "nvim";

}
