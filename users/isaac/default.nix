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

    programs.thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
      settings = {
        # https://support.mozilla.org/en-US/kb/customize-date-time-formats-thunderbird#w_create-date-and-time-format-override-preferences-using-thunderbirds-config-editor
        "intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
        "intl.date_time.pattern_override.time_short" = "HH:mm";
        "mail.biff.play_sound" = false;
        "mail.biff.show_alert" = false;
        "mail.chat.play_sound" = false;
        "mail.chat.show_desktop_notifications" = false;
      };
    };
  };
}
