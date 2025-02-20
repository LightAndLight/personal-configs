{ settings, inputs, config, osConfig, pkgs, ... }:
{
  xresources = {
    properties = {
      "xterm*faceName" = "Hack:size=${builtins.toString osConfig.fontSize}:antialias=true";
      "URxvt.font" = "xft:Hack:size=${builtins.toString osConfig.fontSize}:antialias=true";
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
