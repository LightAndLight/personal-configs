{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      # url = https://github.com/rycee/home-manager/;
      # ref = "refs/heads/release-20.03";
      # `git ls-remote https://github.com/rycee/home-manager release-20.03`
      # rev = "4a8d6280544d9b061c0b785d2470ad6eeda47b02";

      url = /home/isaac/home-manager;
      ref = "refs/heads/taffybar-config";
      rev = "863d7807a5ec67c71c835b52f77a675e04790f2b";
    })
    { inherit pkgs; };
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
    (import ./profiles/common.nix)
    (import ./profiles/personal.nix)
  ];

  home-manager.users.work = pkgs.lib.mkMerge [
    (import ./profiles/common.nix)
    (import ./profiles/work.nix)
  ];
}
