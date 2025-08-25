{ config, pkgs, ...}: {
  environment.systemPackages = [ pkgs.chromium ];
  programs.chromium = {
    enable = true;
    initialPrefs = {
      webkit.webprefs = {
        default_fixed_font_size = 18;
        default_font_size = 18;
        fonts = {
          fixed.Zyyy = "Monospace";
          sansserif.Zyyy = "Sans";
          serif.Zyyy = "Serif";
          standard.Zyyy = "Sans";
        };
      };
    };
  };
}
