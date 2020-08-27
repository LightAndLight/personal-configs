{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    source-code-pro
    dejavu_fonts
  ];
}
