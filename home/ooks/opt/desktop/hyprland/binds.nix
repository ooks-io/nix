{
  wayland.windowManager.hyprland.settings = {
    bind = let
      
      terminal = config.home.sessionVariables.TERMINAL;
      browser = config.home.sessionVariables.BROWSER;
      editor = config.home.sessionVariables.EDITOR;

      makoctl = "${config.services.mako.package}/bin/makoctl";

      playerctl = "${config.services.playerctld.package}/bin/playerctl";
      playerctld = "${config.services.playerctld.package}/bin/playerctld";
      pactl = "${pkgs.pulseaudio}/bin/pactl";
    in [

    # Program Launch
    "SUPER,b,exec,${browser}";
    "SUPER,return,exec,${terminal}";
    "SUPER,e,exec,${editor}";

    #Media

    ",XF86AudioNext,exec,${playerctl} next";
    ",XF86AudioPrev,exec,${playerctl} previous";
    ",XF86AudioPlay,exec,${playerctl} play-pause";
    ",XF86AudioStop,exec,${playerctl} stop";
    
    # Window Management
    
    "SUPER,Q,killactive";
    "SUPERSHIFT ALT,delete,exit";
    "SUPER,F,fullscreen";
    "SUPER,Space,togglefloating";
    "SUPER,P,pseudo"; # dwindle
    "SUPER,S,togglesplit"; # dwindle

    # Focus

    "SUPER,left,movefocus,l";
    "SUPER,right,movefocus,r";
    "SUPER,up,movefocus,u";
    "SUPER,down,movefocus,d";


# ----- MULTIMEDIA KEYBINDS ----- #

binde=, XF86AudioRaiseVolume, exec, ~/.scripts/volume_notify.sh 5%+
binde=, XF86AudioLowerVolume, exec, ~/.scripts/volume_notify.sh 5%-
bind=, XF86AudioMute, exec, ~/.scripts/sounddeviceswap.sh
bind = SUPER, bracketleft, exec, playerctl --player=spotify_player previous
bind = SUPER, bracketright, exec, playerctl --player=spotify_player next
bind = SUPER, backslash, exec, playerctl --player=spotify_player play-pause

# ----- SCREENSHOT KEYBINDS ----- #

bind = SUPER CTRL, escape, exec, hyprshot -m window
bind = SUPER, escape, exec, hyprshot -m region

# ----- MISC KEYBINDS ----- #

bind = SUPER SHIFT, X, exec, hyprpicker -a -n

# ----- WINDOW MANAGEMENT KEYBINDS ----- #

bind = SUPER, Q, killactive,
bind = SUPERSHIFT ALT, delete, exit,
bind = SUPER, F, fullscreen,
bind = SUPER, Space, togglefloating,
bind = SUPER, P, pseudo, # dwindle
bind = SUPER, S, togglesplit, # dwindle

# ----- FOCUS KEYBINDS ----- #

bind = SUPER, left, movefocus, l
bind = SUPER, right, movefocus, r
bind = SUPER, up, movefocus, u
bind = SUPER, down, movefocus, d

# ----- MOVE KEYBINDS ----- #

bind = SUPER SHIFT, left, movewindow, l
bind = SUPER SHIFT, right, movewindow, r
bind = SUPER SHIFT, up, movewindow, u
bind = SUPER SHIFT, down, movewindow, d

# ----- RESIZE KEYBINDS ----- #

bind = SUPER CTRL, left, resizeactive, -20 0
bind = SUPER CTRL, right, resizeactive, 20 0
bind = SUPER CTRL, up, resizeactive, 0 -20
bind = SUPER CTRL, down, resizeactive, 0 20

# ----- TOGGLE KEYBINDS ----- #

bind= SUPER, g, togglegroup
bind= SUPER, tab, changegroupactive

# ----- SPECIAL WORKSPACE KEYBINDS ----- #

# ----- SWITCH WORKSPACE KEYBINDS ----- #

bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10
bind = SUPER ALT, up, workspace, e+1
bind = SUPER ALT, down, workspace, e-1
bind = SUPER, tab, focusCurrentOrLast

# ----- MOVE TO WORKSPACE KEYBINDS ----- #

bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER SHIFT, 6, movetoworkspace, 6
bind = SUPER SHIFT, 7, movetoworkspace, 7
bind = SUPER SHIFT, 8, movetoworkspace, 8
bind = SUPER SHIFT, 9, movetoworkspace, 9
bind = SUPER SHIFT, 0, movetoworkspace, 10

# ----- MOUSE KEYBINDS ----- #

bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow
bind = SUPER, mouse_down, workspace, e+1
bind = SUPER, mouse_up, workspace, e-1

    ];

    };
  }
