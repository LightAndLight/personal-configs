{ osConfig, ...}: {
  programs.thunderbird = {
    settings = {
      # Enable userChrome
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

      # Fonts
      "font.size.monospace.x-western" = osConfig.fonts.size.px;
      "font.size.variable.x-western" = osConfig.fonts.size.px;

      "calendar.week.start" = 0; # Sunday
      "calendar.alarms.playsound" = false;
      "calendar.alarms.showmissed" = false;
      # https://support.mozilla.org/en-US/kb/customize-date-time-formats-thunderbird#w_create-date-and-time-format-override-preferences-using-thunderbirds-config-editor
      "intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
      "intl.date_time.pattern_override.time_short" = "HH:mm";
      "mail.biff.play_sound" = false;
      "mail.biff.show_alert" = false;
      "mail.chat.play_sound" = false;
      "mail.chat.show_desktop_notifications" = false;
      "mail.shell.checkDefaultClient" = false;
      "mailnews.start_page.enabled" = false;

      "widget.non-native-theme.scrollbar.size.override" = builtins.floor (1.5 * osConfig.fonts.size.px);
    };

    profiles.default.userChrome = ''
    '';
  };
}
