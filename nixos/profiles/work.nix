{ ... }: {
  programs.git = {
    enable = true;
    userName = "Isaac Elliott";
    userEmail = "isaac.elliott@paidright.io";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      url = {
        "git@bitbucket.org:" = {
          insteadOf = "https://bitbucket.org/";
        };
      };
    };
  };
  services.keybase.enable = true;
}
