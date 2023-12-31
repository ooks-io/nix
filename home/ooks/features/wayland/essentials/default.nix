{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./kitty.nix
    ./firefox.nix
    ./zathura.nix
    ./gammastep.nix
    ./cursor.nix
    ./swaylock.nix
    ./eww
    ./foot.nix
  ];

  xdg.mimeApps.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  home.packages = with pkgs; [
    grim
    libnotify
    linux-firmware
    pkgs.qt6.qtwayland
    mpv
    gtk3
    mimeo
    waypipe
    pulseaudio
    pamixer
    slurp
    wf-recorder
    wl-clipboard
    wl-mirror
    xdg-utils
    ydotool
    swaybg
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };





}
