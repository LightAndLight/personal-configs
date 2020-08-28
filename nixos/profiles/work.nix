{ ... }: {
  programs.git = {
    enable = true;
    userName = "Isaac Elliott";
    userEmail = "isaac.elliott@paidright.io";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };

  services.keybase.enable = true;
}
