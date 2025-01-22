{ pkgs, ... }:

# # Notes
#
# * The following are necessary to make `MinimizeOn{Close,Startup}` work:
#
#   ```ini
#   ShowTrayIcon=true
#   MinimizeToTray=true
#   ```
#
# * The "Quit" (Ctrl+Q) action in the UI ends the daemon. Keepass windows
#   need to be closed without "Quit"ting for the daemon to remain active.
#
# * The browser extension can pop up a window to request a password for
#   the database, but if you close that window without unlocking then
#   that window won't reappear. You have to restart the daemon to make
#   it work again.

let
  daemonConfig = pkgs.writeText "keepassxc.ini" ''
    [General]
    ConfigVersion=2
    SingleInstance=true

    [Browser]
    CustomProxyLocation=
    Enabled=true

    [GUI]
    TrayIconAppearance=monochrome-light
    ShowTrayIcon=true
    MinimizeToTray=true
    MinimizeOnClose=true
    MinimizeOnStartup=true

    [PasswordGenerator]
    AdditionalChars=
    ExcludedChars=
    Length=25
    LowerCase=true
    SpecialChars=true
    UpperCase=true
  '';
in
{
  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [General]
    ConfigVersion=2
    SingleInstance=true

    [Browser]
    CustomProxyLocation=
    Enabled=true

    [GUI]
    TrayIconAppearance=monochrome-light
    MinimizeOnClose=false
    MinimizeOnStartup=false

    [PasswordGenerator]
    AdditionalChars=
    ExcludedChars=
    Length=25
    LowerCase=true
    SpecialChars=true
    UpperCase=true
  '';

  systemd.user.services.keepassxc = {    
    Unit = {
      Description = "KeePassXC background process";
      PartOf = [ "graphical-session.target" ];
      StartLimitBurst = 5;
      StartLimitIntervalSec = 10;
    };

    Service = {
      Type = "dbus";
      # https://github.com/keepassxreboot/keepassxc/wiki/Using-DBus-with-KeePassXC
      BusName = "org.keepassxc.KeePassXC.MainWindow";
      Environment = ''
        KPXC_CONFIG=${daemonConfig}
      '';
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
      Restart = "on-failure";
      RestartSec = "2s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
