{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Isaac Elliott";
    extraConfig = {
      core = {
        editor = "hx";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = false;
      };
      push = {
        default = "current";
      };
    };
  };
}
