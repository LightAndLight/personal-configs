{ osConfig, ...}: {
  home.pointerCursor = {
    x11.enable = true;
    package = osConfig.ui.cursor.package;
    name = osConfig.ui.cursor.themeName;
    size = osConfig.ui.cursor.size;
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
