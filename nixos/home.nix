{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      url = https://github.com/rycee/home-manager/;
      ref = "refs/heads/release-20.09";
      # `git ls-remote https://github.com/rycee/home-manager release-20.09`
      rev = "63f299b3347aea183fc5088e4d6c4a193b334a41";
    })
    { inherit pkgs; };

  common = import ./profiles/common.nix { settings = config.settings; };
in

{
  imports = [
    home-manager.nixos
  ];

  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.work = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.isaac = pkgs.lib.mkMerge [
    common
    (import ./profiles/personal.nix)
  ];

  home-manager.users.work = pkgs.lib.mkMerge [
    common
    (import ./profiles/work.nix)
  ];
}
