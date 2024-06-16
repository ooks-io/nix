{ lib, config, inputs, pkgs, ... }:

let
  inherit (lib) mkIf;
  multiplexer = config.ooknet.console.multiplexer;
  launcher = config.ooknet.wayland.launcher;
  binds = config.ooknet.binds;
  zellijmenu = pkgs.writeShellApplication {
    name = "zellijmenu";
    runtimeInputs = with pkgs; [ coreutils rofi-wayland ];
    text = /* bash */ ''
      set -e

      type=""
      type_dir=""
      project_name=""
      project_dir=""
      session_name=""
      layout=""
      spawn_terminal=0

      while [[ "$#" -gt 0 ]]; do
        case $1 in
        -n) spawn_terminal=1 ;;
        *)
          echo "Unknown parameter: $1" >&2
          exit 1
          ;;
        esac
        shift
      done

      rofi_cmd() {
        MSG=$1
        rofi -dmenu -i -mesg "$MSG"
      }

      zellij_cmd() {
        if [[ "$spawn_terminal" -eq 1 ]]; then
          ${binds.terminalLaunch} zellij "$@"
        else
          zellij "$@"
        fi
      }

      session_manager() {
        session_list() {
          zellij ls -s | tr ' ' '\n'
        }

        layout_menu() {
          layout_list=$(find ~/.config/zellij/layouts -name "*.kdl" | sed 's|.*/||; s/\.kdl$//' | tr ' ' '\n')
          echo -e "$layout_list" | rofi_cmd "Select layout for $session_name:"
        }

        session_menu() {
          echo -e "$(session_list)" | rofi_cmd "Session:"
        }

        session_select() {
          session_name=$(session_menu)
          if [[ -z "$session_name" ]]; then
            echo "Nothing selected."
            exit 0
          fi

          if session_list | grep -qx "$session_name"; then
            session_action="select"
          else
            session_action="create"
          fi
        }

        selection_menu() {
          echo -e "Attach\nDelete\nBack" | rofi_cmd "$session_name action:"
        }

        while true; do
          session_select
          case $session_action in
          "create")
            layout="$(layout_menu)"
            if [ -z "$layout" ]; then
              echo "No layout given"
              continue
            fi
            zellij_cmd -s "$session_name" --layout "$layout"
            break
            ;;
          "select")
            selection=$(selection_menu)
            case $selection in
            "Attach")
              zellij_cmd attach "$session_name"
              break
              ;;
            "Delete") zellij delete-session --force "$session_name" ;;
            "Back") echo "Going back." ;;
            *) echo "Going Back." ;;
            esac
            ;;
          *) echo "Going Back" ;;
          esac
        done
      }

      project_manager() {
        get_project_type() {
          while true; do
            type=$(echo -e "script\nnix" | rofi_cmd "Select project type:")
            case "$type" in
            script)
              type_dir="$SCRIPTS"
              break
              ;;
            nix)
              type_dir="$NIX_DIR"
              break
              ;;
            *)
              echo "Invalid selection, try again."
              ;;
            esac
          done
        }

        get_project_name() {
          while true; do
            project_name=$(rofi_cmd "Enter project name:")
            if [ -z "$project_name" ]; then
              echo "No name provided, try again."
            elif [ -d "$type_dir/$project_name" ]; then
              echo "Project already exists, try again."
            else
              project_dir="$type_dir/$project_name"
              break
            fi
          done
        }

        get_session_name() {
          session_name="$project_name"
          if zellij ls | grep -q "^$session_name$"; then
            session_name=$(rofi_cmd "Session name '$project_name' in use, enter a new session name:")
            if [ -z "$session_name" ]; then
              echo "No session name entered, exiting."
              exit 1
            fi
          fi
        }

        get_layout() {
          case "$type" in
          script)
            layout="script"
            ;;
          nix)
            layout="nix"
            ;;
          *)
            echo "Unknown project type, using default layout."
            layout="base"
            ;;
          esac
        }

        select_project() {
          project_name=$(find "$type_dir" -maxdepth 1 -mindepth 1 -type d ! -name .git -exec basename {} \; | rofi_cmd "Select project:")
          project_dir="$type_dir/$project_name"

          cd "$project_dir" || return 1
          get_session_name
          get_layout
          zellij_cmd -s "$session_name" --layout "$layout"
        }

        create_and_start_project() {
          mkdir -p "$project_dir"
          cd "$project_dir" || return 1

          case "$type" in
          script)
            echo -e "#!/usr/bin/env bash\necho 'hello world'" >"$project_name.sh"
            chmod +x "$project_name.sh"
            ;;
          nix)
            echo "Creating Nix project..."
            # still need to implement
            ;;
          *)
            echo "Unknown project type."
            return 1
            ;;
          esac

          get_session_name
          get_layout
          zellij_cmd -s "$session_name" --layout "$layout"
        }
        project_action=$(echo -e "Create Project\nSelect Project" | rofi_cmd "Project action:")
        case "$project_action" in
        "Create Project")
          get_project_type
          get_project_name
          create_and_start_project
          ;;
        "Select Project")
          get_project_type
          select_project
          ;;
        esac

      }

      main() {
        main_action=$(echo -e "Projects\nSessions" | rofi_cmd "Choose action:")
        case "$main_action" in
        "Projects") project_manager ;;
        "Sessions") session_manager ;;
        *) echo "Invalid option, exiting." ;;
        esac
      }

      main
    '';
  };
in

{
  config = mkIf (multiplexer == "zellij" && launcher == "rofi") {
    home.packages = [ zellijmenu ];
    ooknet.binds.zellijMenu = "zellijmenu -n";
  };
}
