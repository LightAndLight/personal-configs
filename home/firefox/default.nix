args: {
  programs.firefox = {
    enable = true;
    profiles.isaac = import ./profile.nix args;
  };
}
