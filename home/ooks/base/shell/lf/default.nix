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
  commands = {
    fzf-lf = ''
    ''${{
    res="$(find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m)"
    if [ -d "$res" ] ; then
        cmd="cd"
    elif [ -f "$res" ] ; then
        cmd="select"
    else
        exit 0
    fi
    lf -remote "send $id $cmd \"$res\""
    }}
    '';
    mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
      '';
  };
  keybindings = {
    c = "mkdir";
    "<a-f>" = "fzf-lf";
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
