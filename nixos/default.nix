{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./home.nix
    ./packages.nix
  ];
}
