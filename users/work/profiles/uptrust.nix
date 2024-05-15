{ config, ... }: {
  programs.git = {
    userEmail = "isaac.elliott@uptrusthq.com";
  };

  programs.ssh = {
    enable = true;

    matchBlocks.uptrust-gitlab = {
      hostname = "gitlab.com";
      user = "git";
      identityFile = "${config.home.homeDirectory}/.ssh/uptrust_ed25519";
      identitiesOnly = true;
      extraOptions.PreferredAuthentications = "publickey";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.isaac.isDefault = false;
    profiles.work = {
      id = 1;
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
      #TabsToolbar { visibility: collapse; }
      '';
    };
  };
}
