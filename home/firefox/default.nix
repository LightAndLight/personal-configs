args: {
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.isaac = import ./profile.nix args;
  };
}
