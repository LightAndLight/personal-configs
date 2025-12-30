{ inputs, config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" "syncthing" ];
  };

  home-manager.users.isaac = { projectRoot, ... }: {
    imports = [
      (projectRoot + /home)
      inputs.asker.nixosModules.home-manager
      inputs.tsk.nixosModules.default
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

    programs.tsk = {
      enable = true;
      config.database = "${config.services.syncthing.settings.folders.sync.path}/database.tsk";
    };

    services.asker-prompt.enable = true;
  };
}
