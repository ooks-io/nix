{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./kitty.nix
    ./firefox.nix
    ./zathura.nix
    ./gammastep.nix
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
    slurp
    wf-recorder
    wl-clipboard
    wl-mirror
    xdg-utils
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };





}
