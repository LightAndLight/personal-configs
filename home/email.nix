{
  programs.thunderbird = {
    settings = {
      "calendar.week.start" = 0; # Sunday
      # https://support.mozilla.org/en-US/kb/customize-date-time-formats-thunderbird#w_create-date-and-time-format-override-preferences-using-thunderbirds-config-editor
      "intl.date_time.pattern_override.date_short" = "yyyy-MM-dd";
      "intl.date_time.pattern_override.time_short" = "HH:mm";
      "mail.biff.play_sound" = false;
      "mail.biff.show_alert" = false;
      "mail.chat.play_sound" = false;
      "mail.chat.show_desktop_notifications" = false;
      "mail.shell.checkDefaultClient" = false;
      "mailnews.start_page.enabled" = false;
    };
  };
}