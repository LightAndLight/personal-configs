{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim vscode
    dmenu
    arandr
    xclip
    rxvt_unicode
    nix-prefetch-git
    scrot

    vscode

    man-pages tree ripgrep fd sd jq

    wally-cli

    unzip
  ];
}
