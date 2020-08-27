{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim git firefox dmenu arandr xclip rxvt_unicode
  ];
}
