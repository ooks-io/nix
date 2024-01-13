# Personal nix config
*ook ook*

# Home manager Config

├── profile
│  ├── base.nix
├── programs
│  ├── desktop
│  │  ├── appearance
│  │  │  ├── cursor.nix
│  │  │  ├── default.nix
│  │  │  ├── fonts.nix
│  │  │  ├── gtk.nix
│  │  │  └── qt.nix
│  │  ├── browser
│  │  │  ├── brave
│  │  │  ├── chrome
│  │  │  ├── firefox
│  │  │  └── default.nix
│  │  ├── communication
│  │  │  ├── discord
│  │  │  ├── irc
│  │  │  ├── matrix
│  │  │  ├── teams
│  │  │  └── default.nix
│  ├── shell
│  │  ├── cli
│  │  │  ├── bash.nix
│  │  │  ├── fish.nix
│  │  │  ├── git.nix
│  │  │  ├── lf.nix
│  │  │  ├── starship.nix
│  │  │  ├── tmux.nix
│  │  │  └── zsh.nix
│  │  ├── editor
│  │  │  ├── helix.nix
│  │  │  └── nvim.nix
│  └── default.nix
└── user
   ├── ooks
   │  └── ookst480s
   │     └── default.nix

## Structure
The directories are structured in to a few catagories:

**Programs**
- Contains pre-configures modules for various programs seperated into two catagories:
  - Shell
    - Programs that live in the console or terminal. Shells, TUIs, multiplexers. 
  - Desktop
    - Programs that live in the desktop space. window-managers, terminals, browsers, guis, etc

- Example program module:

~~~ terminals/foot/default.nix
# terminals/foot/default.nix
{ config, lib, ... }:

  let
    inherit (config.colorscheme) colors;
  in

{
  config = {

    home.sessionVariables = lib.mkIf config.programs.desktop.terminal.foot.default {
      TERMINAL = "foot";
      TERM = "foot";
    };

    programs.foot = lib.mkIf config.programs.desktop.terminal.foot.enable {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "${config.fontProfiles.monospace.family}:pixelsize=18:antialias=true";
          font-bold = "${config.fontProfiles.monospace.family}:style=Bold:pixelsize=18:antialias=true";
          font-italic = "${config.fontProfiles.monospace.family}:style=Italic:pixelsize=18:antialias=true";
          font-bold-italic = "${config.fontProfiles.monospace.family}:style=Bold Italic:pixelsize=18:antialias=true";
          ... rest of configuration ...
~~~

~~~ terminals/default.nix
# terminals/default.nix
{ lib, ... }:

{

  imports = [
    ./foot
    ./kitty
  ];

  options.programs.desktop.terminal = {
    foot = {
      enable = lib.mkEnableOption "Enable foot terminal";
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set foot as default terminal in environment variables";
      };
    };
    kitty = {
      enable = lib.mkEnableOption "Enable kitty terminal";
      default = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Set kitty as default terminal in environment variables";
      };
    };
  };
}

~~~

- In the above example the *foot* terminal pre-configured and turned into a *home-manager* module, this can then later be enable in a **profile** file. 

**Profiles**

- Profiles are a list of included modules that are then later imported into my home-managers **user** file
- example:
~~~ profile/base.nix
# profile/base.nix
{ lib, config, ... }:
{
  config = lib.mkIf config.profile.base.enable {
    programs = {
      desktop = {
        terminal = {
          foot = {
            enable = true;
            default = true;
          };
        }; 
        browser.firefox = {
          enable = true;
          default = true;
        };
      };
      shell = {
        cli = {
          git.enable = true;
        };
      };
    };  
  };
}
~~~

~~~ profile/default.nix
# profile/default.nix
{ lib, ... }:
{
  imports = [
    ./base.nix
    ./creative.nix
  ];

  options.profile = {
    base = {
      enable = lib.mkEnableOption "Enable base profile";
    };
    creative = {
      enable = lib.mkEnableOption "Enable creative profile";
    };
  };
}

~~~
  

**User**

- The user files are the entry point for the user & mashine's home-manager confiuration, it
- example configuration:

~~~ user/ooks/ookst480s/default.nix
# user/ooks/ookst480s/default.nix
{ inputs, outputs, config, ... }:

{
  imports = [
    ../../../profile
  ];

  profile.base.enable = true;

  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
    primary = true;
    transform = 0;
  }];
  
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-soft;

}

~~~

- In the example above the user *ooks* on the machine *ookst480s* enables the base profile and configures the monitors/colorscheme to use.
- This is then imported into the flake as such:

~~~ flake.nix
# flake.nix

# ... flake configuration ...
  homeConfigurations = {
    # T480s
    "ooks@ookst480s" = lib.homeManagerConfiguration {
      modules = [ ./home/user/ooks/t480s ];
      pkgs = pkgsFor.x86_64-linux;
      extraSpecialArgs = { inherit inputs outputs; };
    };    
  };
# ... rest of configuration ...

~~~


   


