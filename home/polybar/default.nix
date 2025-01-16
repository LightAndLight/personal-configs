{ osConfig, ... }:
{
  services.polybar = {
    enable = true;
    script = ''
      polybar top &
      polybar bottom &
    '';
  };

  home.file.".config/polybar/config.ini".text = import ./config.ini.nix {
    dpi = osConfig.settings.dpi;
    fontSize = osConfig.fontSize;
  };
}
