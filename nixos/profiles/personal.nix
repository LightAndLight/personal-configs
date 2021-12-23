{ ... }: {
  programs.git = {
    enable = true;
    userName = "Isaac Elliott";
    userEmail = "isaace71295@gmail.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };
}
