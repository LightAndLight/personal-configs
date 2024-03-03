{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Desktop management
    dmenu

    # Text editing
    neovim vscode

    # Display
    arandr scrot

    # Misc. tools
    man-pages
    tree
    ripgrep
    fd
    jq
    unzip
    nix-prefetch-git
    xclip

    wally-cli

    (spotify.override {
      # Scale up the UI for HiDPI displays.
      deviceScaleFactor = 2.0;
    })
  ];
}
