{ pkgs, osConfig, ...}: {
  home.pointerCursor = {
    x11.enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = builtins.floor (1.5 * osConfig.fontSize * (1.0 / 72) * osConfig.settings.dpi);
  };

  xdg.configFile."gtk-3.0/gtk.css".text = ''
    scrollbar, scrollbar button, scrollbar slider {
      -GtkScrollbar-has-backward-stepper: true;
      -GtkScrollbar-has-forward-stepper: true;
      min-width: ${builtins.toString osConfig.fontSize}pt;
      min-height: ${builtins.toString osConfig.fontSize}pt;
      border-radius: 0;
    }
  '';
}
