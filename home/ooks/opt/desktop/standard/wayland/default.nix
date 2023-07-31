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
    mkv
    gtk3
    pulseaudio
    slurp
    wf-recorder
    wl-clipboard
    wl-mirror
    wl-mirror-pick
    xdg-utils
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
    EDITOR = "nvim";
    BROWSER = "firefox";
  };





}
