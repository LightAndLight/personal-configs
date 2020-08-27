{ config, pkgs, ... }:

{
  nixpkgs.overlays = import ./overlays.nix;
  
  services.xserver.windowManager = {
    xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = pkgs: [ pkgs.taffybar ];
    };
  };
}
