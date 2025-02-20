{ pkgs, osConfig, ...}: {
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
