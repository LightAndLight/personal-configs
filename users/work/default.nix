{ config, pkgs, ... }: {
  users.users.work = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.work = pkgs.lib.mkMerge [
    (import ../../profiles/common.nix { settings = config.settings; })
  ];
}
