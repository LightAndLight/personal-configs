{ config, pkgs, ... }:

let
  home-manager =
    import (builtins.fetchGit {
      name = "home-manager";
      url = https://github.com/rycee/home-manager/;
      ref = "refs/heads/release-20.03";
      # `git ls-remote https://github.com/rycee/home-manager release-20.03`
      rev = "4a8d6280544d9b061c0b785d2470ad6eeda47b02";
    })
    {};
in

{
  imports = [
    home-manager.nixos
  ];
  
  users.users.isaac = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };
  
  home-manager.users.isaac = { pkgs, ... }: {
    home.file.".emacs.d" = { 
      recursive = true; 
      source = builtins.fetchGit {
        name = "spacemacs";
        url = https://github.com/syl20bnr/spacemacs/;
        ref = "refs/heads/develop";
        # `git ls-remote https://github.com/syl20bnr/spacemacs develop`
        rev = "15d93914f5caf6a3a15c573da60576313b0eee04";
      };
    };
    home.file.".spacemacs" = {
      source = ./files/spacemacs;
    }
    
    programs.fish.enable = true;
    programs.git = {
      enable = true;
      userName = "Isaac Elliott";
      userEmail = "isaace71295@gmail.com";
      extraConfig = {
        core = {
	  editor = "nvim";
	};
      };
    };
  };
}
