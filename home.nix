{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      url = https://github.com/rycee/home-manager/;
      ref = "refs/heads/release-23.11";
      # `git ls-remote https://github.com/rycee/home-manager release-23.11`
      rev = "652fda4ca6dafeb090943422c34ae9145787af37";
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
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" ];
  };

  users.users.work = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.isaac = pkgs.lib.mkMerge [
    common
    (import ./profiles/personal.nix)
  ];

  # Disabled to debug slow boot times.
  #
  # home-manager.users.work = pkgs.lib.mkMerge [
  #   common
  # ];
}
