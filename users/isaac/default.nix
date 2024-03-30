{ config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.isaac = pkgs.lib.mkMerge [
    (import ../../profiles/common.nix { settings = config.settings; })
    (import ../../profiles/personal.nix)
  ];
}
