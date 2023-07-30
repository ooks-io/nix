{ home, colorscheme }:
let
  inherit (home.sessionVariables) TERMINAL BROWSER EDITOR;
in
  d
''
  general {
    gaps_in=15
    gaps_out=20

    border_size=2.7
    col.active_border=0xff${colorscheme.colors.base0C}
    col.inactive_border=0xff${colorscheme.colors.base02}
    col.group_border_active=0xff${colorscheme.colors.base0B}
    col.group_border=0xff${colorscheme.colors.base04}
    
    cursor_inactive_timeout=4
  }

  decoration {
    active_opacity=0.94
    inactive_opacity=0.84
    fullscreen_opacity=1.0
    
    rounding=5
    
    blur=true
    blur_size=5
    blur_passes=3
    blur_new_optimizations=true
    blur_ignore_opacity=true
    
    drop_shadow=true
    shadow_range=12
    shadow_offset=3 3
    col.shadow=0x44000000
    col.shadow_inactive=0x66000000
  }

  animations {
    enabled=true

    bezier=easein,0.11, 0, 0.5, 0
    bezier=easeout,0.5, 1, 0.89, 1
    bezier=easeinout,0.45, 0, 0.55, 1

    animation=windowsIn,1,3,easeout,slide
    animation=windowsOut,1,3,easein,slide
    animation=windowsMove,1,3,easeout

    animation=fadeIn,1,3,easeout
    animation=fadeOut,1,3,easein
    animation=fadeSwitch,1,3,easeout
    animation=fadeShadow,1,3,easeout
    animation=fadeDim,1,3,easeout
    animation=border,1,3,easeout

    animation=workspaces,1,2,easeout,slide
  }

    misc {
      animate_manual_resizes = false
      enable_swallow = true
      swallow_regex = ^(kitty)$
      focus_on_activate = true
      disable_hyprland_logo = true
      vfr = on
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes
    }

    master {
      new_is_master = true
    }


