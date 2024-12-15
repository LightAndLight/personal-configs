{ config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.isaac = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home)
    ];

    programs.git = {
      enable = true;
      userName = "Isaac Elliott";
      userEmail = "isaace71295@gmail.com";
    };

    accounts.email.accounts.isaac = {
      primary = true;
      realName = "Isaac Elliott";
      address = "isaace71295@gmail.com";
      thunderbird = {
        enable = true;
        settings = {
          # https://support.mozilla.org/en-US/kb/customize-date-time-formats-thunderbird#w_create-date-and-time-format-override-preferences-using-thunderbirds-config-editor
          "intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
          "intl.date_time.pattern_override.time_short" = "HH:mm";
        };
      };
    };
  };
}
