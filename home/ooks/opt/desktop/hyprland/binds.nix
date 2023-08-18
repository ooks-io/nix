{ lib, config, pkgs, ... }: {

  wayland.windowManager.hyprland.settings = {
    bind = let
      terminal = config.home.sessionVariables.TERMINAL;
      browser = config.home.sessionVariables.BROWSER;
      editor = config.home.sessionVariables.EDITOR;

      spotify = "${terminal} -e spotify_player";

      makoctl = "${config.services.mako.package}/bin/makoctl";

      playerctl = "${config.services.playerctld.package}/bin/playerctl";
      playerctld = "${config.services.playerctld.package}/bin/playerctld";
      pactl = "${pkgs.pulseaudio}/bin/pactl";
    in [

      # Program Launch
      "SUPER,b,exec,${browser}"
      "SUPER,return,exec,${terminal}"
      "SUPER,e,exec,${editor}"
      "SUPER,m,exec,${spotify}"

      # Media

      "SUPER,bracketright,exec,${playerctl} --player=spotify_player next"
      "SUPER,bracketleft,exec,${playerctl} --player=spotify_player previous"
      "SUPER,backslash,exec,${playerctl} --player=spotify_player play-pause"

      # Brightness

      ",XF86MonBrightnessUp,exec,light -A 10"
      ",XF86MonBrightnessDown,exec,light -U 10"

      # Volume

      ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
      ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
      "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      
      # Window Management
      
      "SUPER,Q,killactive"
      "SUPER,backspace,killactive"
      "SUPERSHIFT ALT,delete,exit"
      "SUPER,F,fullscreen"
      "SUPER,Space,togglefloating"
      "SUPER,P,pseudo" # dwindle
      "SUPER,S,togglesplit" # dwindle

      # Focus

      "SUPER,left,movefocus,l"
      "SUPER,right,movefocus,r"
      "SUPER,up,movefocus,u"
      "SUPER,down,movefocus,d"

      # Move

      "SUPERSHIFT,left,movewindow,l"
      "SUPERSHIFT,right,movewindow,r"
      "SUPERSHIFT,up,movewindow,u"
      "SUPERSHIFT,down,movewindow,d"

      #Resize

      "SUPER CTRL,left,resizeactive,-20 0"
      "SUPERCTRL,right,resizeactive,20 0"
      "SUPER CTRL,up,resizeactive, 0 -20"
      "SUPERCTRL,down,resizeactive, 0 20"

      # Switch workspace
    
      "SUPER,1,workspace,1"
      "SUPER,2,workspace,2"
      "SUPER,3,workspace,3"
      "SUPER,4,workspace,4"
      "SUPER,5,workspace,5"
      "SUPER,6,workspace,6"
      "SUPER,7,workspace,7"
      "SUPER,8,workspace,8"
      "SUPER,9,workspace,9"
      "SUPER,0,workspace,10"
      "SUPER,comma,workspace,e+1"
      "SUPER,period,workspace,e-1"
      "SUPER,tab,focusCurrentOrLast"

      # Move workspace

      "SUPERSHIFT,1,movetoworkspace,1"
      "SUPERSHIFT,2,movetoworkspace,2"
      "SUPERSHIFT,3,movetoworkspace,3"
      "SUPERSHIFT,4,movetoworkspace,4"
      "SUPERSHIFT,5,movetoworkspace,5"
      "SUPERSHIFT,6,movetoworkspace,6"
      "SUPERSHIFT,7,movetoworkspace,7"
      "SUPERSHIFT,8,movetoworkspace,8"
      "SUPERSHIFT,9,movetoworkspace,9"
      "SUPERSHIFT,0,movetoworkspace,10"
    ];
# ----- MOUSE KEYBINDS ----- #
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];

  };
}
