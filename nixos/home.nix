{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      url = https://github.com/rycee/home-manager/;
      ref = "refs/heads/release-21.05";
      # `git ls-remote https://github.com/rycee/home-manager release-21.05`
      rev = "9c0abed5228d54aad120b4bc757b6f5935aeda1c";
    })
    { inherit pkgs; };

  common = import ./profiles/common.nix { settings = config.settings; };
in

{
  imports = [
    home-manager.nixos
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  environment.systemPackages = [ pkgs.pavucontrol ];

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
