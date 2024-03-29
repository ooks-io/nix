{ inputs, lib, pkgs, config, outputs, ... }:
let
  cfg = config.profiles.base;
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) nixWallpaperFromScheme;
in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    ../../modules
    ../../secrets
  ];

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    };

    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = [ "nix-command" "flakes" "repl-flake" ];
        warn-dirty = false;
      };
    };

    programs = {
      home-manager.enable = true;
      git.enable = true;
    };
    home.packages = with pkgs; [ sops ];

    home = {
      username = lib.mkDefault "ooks";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.05";
      sessionPath = [ "$HOME/.local/bin" ];
      sessionVariables = {
        FLAKE = "$HOME/Coding/nix/ooks-io/nix";
        SCRIPTS = "$HOME/Coding/sh/scripts";
        TZ = "Pacific/Auckland";
      };
    };
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_CODE_DIR = "${config.home.homeDirectory}/Coding";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_NOTES_DIR = "${config.xdg.userDirs.documents}/Notes";
        XDG_RECORDINGS_DIR = "${config.xdg.userDirs.videos}/Recordings";
      };
    };

    xdg.portal.enable = true;

    homeModules = {
      sops.enable = true;
      console = {
        editor.helix = {
          enable = true;
          default = true;
        };
        prompt.starship.enable = true;
        shell = {
          fish.enable = true;
          bash.enable = true;
        };
        multiplexer.zellij.enable = true;
        utility = {
          ssh.enable = true;
          nixIndex.enable = true;
          git.enable = true;
          tools.enable = true;
          transientServices.enable = true;
        };
      };
    };  

    wallpaper =
      let
        largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
        largestWidth = largest (x: x.width) config.monitors;
        largestHeight = largest (x: x.height) config.monitors;
      in
      lib.mkDefault (nixWallpaperFromScheme
        {
          scheme = config.colorscheme;
          width = largestWidth;
          height = largestHeight;
          logoScale = 4;
        });
    colorscheme = lib.mkDefault colorSchemes.everforest;
    home.file.".colorscheme".text = config.colorscheme.slug;
  };
}
