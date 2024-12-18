{ config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.isaac = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home)
    ];

    programs.git = {
      enable = true;
      userName = "Isaac Elliott";
      userEmail = "isaace71295@gmail.com";
    };

    programs.thunderbird = {
      enable = true;
      profiles.default.isDefault = true;
    };
  };
}
