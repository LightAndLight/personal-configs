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

  home-manager.users.isaac = { pkgs, ... }: {
    programs.fish.enable = true;
    programs.git = {
      enable = true;
      userName = "Isaac Elliott";
      userEmail = "isaace71295@gmail.com";
    };
  };
}
