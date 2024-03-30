{ config, pkgs, ... }: {
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # provided by home-manager
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.isaac = pkgs.lib.mkMerge [
    (import ../../home.nix { settings = config.settings; })
    {
      programs.git = {
        enable = true;
        userName = "Isaac Elliott";
        userEmail = "isaace71295@gmail.com";
      };      
    }
  ];
}
