{ config, pkgs, inputs, system, ... }:

{
  imports = [ ./packages/chromium.nix ];

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

    # Password management
    keepassxc

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

    wally-cli

    (spotify.override {
      # Scale up the UI for HiDPI displays.
      deviceScaleFactor = if config.settings.hiDPI then 2.0 else 1.0;
    })

    # Tools
    (pkgs.callPackage ./packages/mdpreview {
      ipso = inputs.ipso.defaultPackage.${system};
    })
    (pkgs.callPackage ./packages/scrap.nix {})
    (pkgs.callPackage ./packages/slowly.nix {})
    inputs.xeval.packages.${system}.default
    (pkgs.callPackage ./packages/gen-alias.nix {
      gen-alias = inputs.gen-alias.packages.${system}.default;
    })
    (pkgs.callPackage ./packages/mdlink {})
    (pkgs.haskell.lib.justStaticExecutables (pkgs.haskellPackages.callPackage "${inputs.rand}/rand.nix" {}))
  ];
}
