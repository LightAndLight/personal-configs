{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      url = https://github.com/rycee/home-manager/;
      ref = "refs/heads/release-22.05";
      # `git ls-remote https://github.com/rycee/home-manager release-22.05`
      rev = "4a3d01fb53f52ac83194081272795aa4612c2381";
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
  ];
}
