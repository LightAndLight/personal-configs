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
          indicators=~host;~spacer;~clock;~power
        '';
      };
    };
  };
}
