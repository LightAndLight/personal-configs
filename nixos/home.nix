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
    { inherit pkgs; };
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
    nixpkgs.overlays = import ./overlays.nix;
  
    home.file.".xprofile" = {
      text = ''
      ${pkgs.haskellPackages.status-notifier-item}/bin/status-notifier-watcher &
      ${pkgs.haskellPackages.taffybar}/bin/taffybar &
      '';
    };

    xresources = {
      properties = {
        "xterm*faceName" = "DejaVu Sans Mono:size=12:antialias=true";
        "URxvt.font" = "xft:DejaVu Sans Mono:size=12:antialias=true";
        "URxvt.scrollBar" = "false";
        "Xft.dpi" = "284";
        "Xft.antialias" = "1";
      };
      extraConfig =
        let
          gruvbox-contrib =
            pkgs.fetchFromGitHub {
              owner = "morhetz";
              repo = "gruvbox-contrib";
              rev = "edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
              sha256 = "0n32s5var4xxwk3bwm70mwja0gy6vaj2awm6kji10yw3fpqgg7yh";
            };
        in
          builtins.readFile (
            "${gruvbox-contrib}/xresources/gruvbox-dark.xresources"
          );
    };
    
    programs.emacs.enable = true;
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
    home.file.".emacs.d/private/spacemacs-neuron" = { 
      recursive = true;
      source = builtins.fetchGit {
        name = "spacemacs-neuron";
        url = https://github.com/LightAndLight/spacemacs-neuron/;
        ref = "refs/heads/master";
        # `git ls-remote https://github.com/LightAndLight/spacemacs-neuron master`
        rev = "de11867cedb0eb9a94a84e1353f24224c1076293";
      };
    };
    home.file.".spacemacs" = {
      source = ./files/spacemacs;
    };
    
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
