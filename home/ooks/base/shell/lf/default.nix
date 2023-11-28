{ pkgs, config, ... }:
#TODO mkif wayland for previewer
{

xdg.configFile."lf/icons".source = ./icons;

programs.lf = {
  enable = true;
  settings = {
    hidden = true;
    ignorecase = true;
    drawbox = true;
    icons = true;
  };
  previewer = {
    keybinding = "i";
    source = "${pkgs.ctpv}/bin/ctpv";
  };
  extraConfig = ''
    &${pkgs.ctpv}/bin/ctpv -s $id
    cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
    set cleaner ${pkgs.ctpv}/bin/ctpvclear
    set sixel true
  '';
};    
  

  home.packages = with pkgs; [ chafa ctpv glow ];
}
