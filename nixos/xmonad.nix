{ config, pkgs, ... }:

{
  nixpkgs.overlays =
    let
      unstable =
        import (builtins.fetchGit {
          name = "nixos-unstable-2020-04-04";
          url = https://github.com/nixos/nixpkgs-channels/;
          ref = "refs/heads/nixos-unstable";
          # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
          rev = "683c68232e91f76386db979c461d8fbe2a018782";
        })
        {};
    in
      [
        (self: super: {
          haskellPackages = super.haskellPackages.override {
            overrides = old: new: {
              taffybar = unstable.haskellPackages.taffybar;
            };
          };
        })
      ];

  environment.systemPackages = with pkgs; [
    haskellPackages.taffybar haskellPackages.status-notifier-item
  ];

  services.xserver.windowManager = {
    xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = pkgs: [ pkgs.taffybar ];
    };
  };
}