{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = ooks-io;
    userEmail = ooks@protonmail.com;
  };
}
