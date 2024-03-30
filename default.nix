{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./home.nix
    ./packages.nix
    ./xserver.nix
    ./settings.nix
  ];

  config = {
    hardware.keyboard.zsa.enable = true;
  };
}
