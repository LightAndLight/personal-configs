{ ... }: {
  programs.git = {
    userEmail = "isaac.elliott@paidright.io";
    extraConfig = {
      url = {
        "git@bitbucket.org:" = {
          insteadOf = "https://bitbucket.org/";
        };
      };
    };
  };
  services.keybase.enable = true;
}
