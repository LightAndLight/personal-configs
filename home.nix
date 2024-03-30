{ config, pkgs, ... }:
let
  common = import ./profiles/common.nix { settings = config.settings; };
in
{
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
