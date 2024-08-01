{ settings, inputs, config, pkgs, ... }:
{
  home.pointerCursor = {
    x11.enable = false;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 32;
  };

  xresources = {
    properties = {
      "xterm*faceName" = "Hack:size=12:antialias=true";
      "URxvt.font" = "xft:Hack:size=12:antialias=true";
      "URxvt.scrollBar" = "false";
      "Xft.dpi" = settings.dpi;
      "Xft.antialias" = "1";
      "Xcursor.theme" = config.home.pointerCursor.name;
      "Xcursor.size" = config.home.pointerCursor.size;
    };
    extraConfig =
      builtins.readFile "${inputs.gruvbox-contrib}/xresources/gruvbox-dark.xresources";
  };  
}
