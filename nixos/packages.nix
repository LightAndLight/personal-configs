{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim vscode
    dmenu
    arandr
    xclip
    rxvt_unicode
    nix-prefetch-git
    scrot

    man-pages tree ripgrep fd sd jq
  ];
}
