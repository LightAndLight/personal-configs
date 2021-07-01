{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    dmenu
    arandr
    xclip
    rxvt_unicode
    nix-prefetch-git
    scrot
  ];
}
