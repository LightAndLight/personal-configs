{
  services.polybar = {
    enable = true;
    script = ''
      polybar top &
      polybar bottom &
    '';
  };

  home.file.".config/polybar/config.ini".source = ./config.ini;
}
