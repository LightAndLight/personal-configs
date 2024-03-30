{ config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.isaac = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home.nix)
    ];

    programs.git = {
      enable = true;
      userName = "Isaac Elliott";
      userEmail = "isaace71295@gmail.com";
    };
  };
}
