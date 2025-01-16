{ config, ... }: {
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-font-name="Sans ${builtins.toString config.fontSize}"
  '';

  # https://answers.launchpad.net/lightdm-gtk-greeter/+question/232911
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans ${builtins.toString config.fontSize}
  '';

  environment.etc."xdg/gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Sans ${builtins.toString config.fontSize}
  '';
      
  # <https://github.com/Xubuntu/lightdm-gtk-greeter/blob/master/data/lightdm-gtk-greeter.conf>
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    font-name=Sans,${builtins.toString config.fontSize}
  '';
}
