{ config, pkgs, ... }: {
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
    profiles.work = (import ../../../home/firefox/profile.nix) // {
      id = 1;
      isDefault = true;
    };
  };

  home.packages = with pkgs; [
    slack
  ];
}
