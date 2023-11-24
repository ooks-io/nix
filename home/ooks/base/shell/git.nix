{ pkgs, config, ... }:
{ 
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "ooks-io";
    userEmail = "ooks@protonmail.com";
    extraConfig = {
      gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };
  };
  
  home.packages = with pkgs; [
    git-credential-1password
    ];
}
