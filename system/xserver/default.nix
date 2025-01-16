{ config, ... }:

{
  services.displayManager.defaultSession = "xterm";

  services.libinput = {
    enable = true;
    touchpad = {
      scrollMethod = "twofinger";
      naturalScrolling = true;
    };
  };

  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-font-name="Sans 12"
  '';

  # https://answers.launchpad.net/lightdm-gtk-greeter/+question/232911
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans 12
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans 12
  '';

  services.xserver = {
    enable = true;

    dpi = config.settings.dpi;

    xkb.layout = "us";

    desktopManager = {
      xterm.enable = true;
    };

    displayManager.lightdm = {
      enable = true;

      # Generated using https://github.com/lunik1/nix-wallpaper
      background = ./nix-wallpaper.png;

      greeters.gtk = {
        enable = true;

        # <https://github.com/Xubuntu/lightdm-gtk-greeter/blob/master/data/lightdm-gtk-greeter.conf>
        extraConfig = ''
          font-name=Source Sans 3,12
          indicators=~host;~spacer;~clock;~power
        '';
      };
    };
  };
}
