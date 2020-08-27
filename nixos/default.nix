{ config, pkgs, ... }:

{
  imports = [
    ./home.nix
    ./packages.nix
    ./xmonad.nix
  ];
}
