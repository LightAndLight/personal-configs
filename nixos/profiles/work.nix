{ ... }: {
  services.xscreensaver = {
    enable = true;
    settings = {
      lock = "True";
      fade = "False";
      unfade = "False";
      fadeSeconds = "0:00:00";
    };
  };

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
