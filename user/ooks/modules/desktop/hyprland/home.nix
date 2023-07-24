 config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/hypr-variable.nix)
  ];
  programs = {
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
    fish = {
      loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = false;
    extraConfig = '' 
     monitor=,preferred,auto,auto

     exec-once = swaybg -i ~/.dotfiles/walls/everforest/megacity.png

      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {

          gaps_in = 5
          gaps_out = 5
          border_size = 2
          col.active_border = 0xffA7C080
          col.inactive_border = rgba(595959aa)

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 5
          multisample_edges = true
          blur = no
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = on

          drop_shadow = no
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      misc {
          animate_manual_resizes = false
          enable_swallow = true
          swallow_regex = ^(kitty)$
          focus_on_activate = true
          disable_hyprland_logo = true
      }
# Animations
# -------------------------------------------------------------------------------------------------

      animations {
        enabled = yes
        bezier = overshot, 0.11, 1, 0.36, 1
              animation = windows, 1, 4, overshot, slide
              animation = windowsOut, 1, 5, default, popin 80%
              animation = border, 1, 5, default
              animation = fade, 1, 8, default
        animation = workspaces, 1, 6, overshot, slide
            }

# Layout
# -------------------------------------------------------------------------------------------------

      }

      dwindle {
            pseudotile = yes
        preserve_split = yes
      }

      master {
        new_is_master = true
      }

# Gestures
# -------------------------------------------------------------------------------------------------

      gestures {
            workspace_swipe = off
      }

# Device Config
# -------------------------------------------------------------------------------------------------

      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

# Window Rules
# -------------------------------------------------------------------------------------------------

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

# Main Mod
# -------------------------------------------------------------------------------------------------

      $mainMod = SUPER

# Program Binds
# -------------------------------------------------------------------------------------------------

      bind = $mainMod, return, exec, kitty
      bind = $mainMod, Q, killactive, 
      bind = $mainMod, B, exec, firefox
      bind = $mainMod, M, exit, 
      bind = $mainMod, space, togglefloating, 
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

# Workspaces
# -------------------------------------------------------------------------------------------------

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      binds {
                 workspace_back_and_forth = 1 
                 allow_workspace_cycles = 1
            }
            bind=$mainMod,tab,workspace,previous

# Move To Workspaces
# -------------------------------------------------------------------------------------------------

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Workspaces Scroll
# -------------------------------------------------------------------------------------------------

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      '';
    };
  }
