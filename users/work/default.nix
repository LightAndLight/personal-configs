{ projectRoot, config, pkgs, ... }: {
  users.users.work = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" "syncthing" ];
  };

  home-manager.users.work = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home)
      ./profiles/uptrust.nix
    ];
  };
}
