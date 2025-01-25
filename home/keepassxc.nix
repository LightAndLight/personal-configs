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
# * The browser extension can pop up a window to request a password for
#   the database, but if you close that window without unlocking then
#   that window won't reappear. You have to restart the daemon to make
#   it work again.

let
  commonConfig = ''
    [PasswordGenerator]
    AdditionalChars=
    ExcludedChars=
    Length=25
    LowerCase=true
    SpecialChars=true
    UpperCase=true
  '';

  # The `keepassxc` daemon is used by browser extensions (`[Browser].Enabled = true`).
  # It's not intended to have a GUI, so it's started minimised and remains that way.
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

    ${commonConfig}
  '';

  # Standalone `keepassxc` instances are started using the launcher or CLI.
  # They are independent (`[General].SingleInstance=false`) and don't minimise.
  # They have no browser integration (`[Browser].Enabled = false`).
  standaloneConfig = pkgs.writeText "keepassxc.ini" ''
    [General]
    ConfigVersion=2
    SingleInstance=false

    [Browser]
    CustomProxyLocation=
    Enabled=false

    [GUI]
    TrayIconAppearance=monochrome-light
    ShowTrayIcon=false
    MinimizeToTray=false
    MinimizeOnClose=false
    MinimizeOnStartup=false

    ${commonConfig}
  '';
in
{
  xdg.configFile."keepassxc/keepassxc.ini".source = standaloneConfig;

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
      Environment =
        pkgs.lib.strings.concatMapStringsSep " " (x: "\"${x}\"")
          [
            "KPXC_CONFIG=${daemonConfig}"

            # Ensure dialogs have the correct theme and scaling.
            #
            # See also: `system/display.nix`
            "QT_QPA_PLATFORMTHEME=qt5ct"
            "QT_SCALE_FACTOR_ROUNDING_POLICY=PassThrough"
          ];
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
      Restart = "on-failure";
      RestartSec = "2s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
