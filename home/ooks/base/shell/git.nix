{ pkgs, config, ... }:
{ 
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "ooks-io";
    userEmail = "ooks@protonmail.com";
  };
  
  home.packages = with pkgs; [
    git-credential-1password
    ];
}
