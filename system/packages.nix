{ config, pkgs, inputs, system, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Desktop management
    dmenu

    # Text editing
    neovim vscode

    # Display
    arandr scrot gimp

    # System status
    htop

    # Misc. tools
    man-pages
    tree
    ripgrep
    fd
    jq
    unzip
    nix-prefetch-git
    xclip
    moreutils

    chromium

    wally-cli

    (spotify.override {
      # Scale up the UI for HiDPI displays.
      deviceScaleFactor = if config.settings.hiDPI then 2.0 else 1.0;
    })

    (pkgs.callPackage ./packages/mdpreview {
      ipso = inputs.ipso.defaultPackage.${system};
    })
    (pkgs.callPackage ./packages/scrap.nix {})
    (pkgs.callPackage ./packages/slowly.nix {})
    inputs.xeval.packages.${system}.default
  ];
}
