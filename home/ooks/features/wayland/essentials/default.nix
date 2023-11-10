{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./kitty.nix
    ./firefox.nix
    ./zathura.nix
    ./gammastep.nix
    ./cursor.nix
    ./gimp.nix
    ./swaylock.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    grim
    libnotify
    linux-firmware
    pkgs.qt6.qtwayland
    mpv
    gtk3
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
