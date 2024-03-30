{ projectRoot, config, pkgs, ... }: {
  users.users.work = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.work = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home.nix)
      ./profiles/inactive.nix
    ];
  };
}
