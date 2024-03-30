{ config, ... }: {
  programs.git = {
    userEmail = "isaac@ninebyte.com";
  };

  programs.ssh = {
    enable = true;

    matchBlocks.ninebyte-gitlab = {
      hostname = "gitlab.com";
      user = "git";
      identityFile = "${config.home.homeDirectory}/.ssh/ninebyte";
      identitiesOnly = true;
    };
  };
}
