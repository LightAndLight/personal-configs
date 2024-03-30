{
  programs.firefox = {
    enable = true;
    profiles.isaac = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
      #TabsToolbar { visibility: collapse; }
      '';
    };
  };
}
