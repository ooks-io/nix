{
  imports = [
    ./qt.nix
    ./gtk.nix
    ./imv.nix
    ./fonts.nix
    ./playerctl.nix
    ./pavucontrol.nix
    ./music.nix
    ./yt-dlp.nix
    ./playerctl.nix
  ];
  xdg.portal.enable = true;
}
