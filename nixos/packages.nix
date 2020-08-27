{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim 
    firefox 
    dmenu 
    arandr 
    xclip 
    rxvt_unicode
    nix-prefetch-git
  ];
}
