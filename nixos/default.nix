{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./xmonad.nix
  ];
}
