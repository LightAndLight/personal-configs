{ pkgs, config, ... }: {
  imports = [
    ./ui/options.nix
  ];

  ui.cursor = {
    package = pkgs.vanilla-dmz;
    themeName = "Vanilla-DMZ";
    size = builtins.floor (3 * config.fonts.size.px);
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.variables = {
    # When a screen's DPI is an integer multiple of 96, the effect of this isn't noticeable.
    #
    # My laptop has a DPI of 144, which is `1.5*96`.
    # The default for `QT_SCALE_FACTOR_ROUNDING_POLICY` was causing this to round to 2, which
    # made QT apps look awkwardly scaled up.
    QT_SCALE_FACTOR_ROUNDING_POLICY = "PassThrough";
  };

  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-font-name="Sans ${builtins.toString config.fonts.size.pt_at_96dpi}"
  '';

  # https://answers.launchpad.net/lightdm-gtk-greeter/+question/232911
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans ${builtins.toString config.fonts.size.pt_at_96dpi}
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans ${builtins.toString config.fonts.size.pt_at_96dpi}
  '';

  # <https://github.com/Xubuntu/lightdm-gtk-greeter/blob/master/data/lightdm-gtk-greeter.conf>
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    font-name=Sans,${builtins.toString config.fonts.size.pt_at_96dpi}
  '';
}
