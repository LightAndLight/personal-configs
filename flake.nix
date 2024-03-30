{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    gruvbox-contrib = {
      url = "github:morhetz/gruvbox-contrib?rev=edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
      flake = false;
    };

    spacemacs = {
      url = "github:syl20bnr/spacemacs?rev=6774f37fc1c542fab664f1b65931e52a4991d71a";
      flake = false;
    };

    spacemacs-neuron = {
      url = "github:LightAndLight/spacemacs-neuron?rev=3750b3e7793f50e11ffac3aa0425a56fc279d5ab";
      flake = false;
    };

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish?rev=1eaed8c39951029fa7839859abd5518977a80f83";
      flake = false;
    };
  };
  outputs =
    { 
      self, nixpkgs, home-manager,
      gruvbox-contrib,
      spacemacs,
      spacemacs-neuron,
      theme-bobthefish
    }:
    {
      nixosConfigurations.isaac-nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                projectRoot = ./.;
                settings = config.settings;
                inputs = {
                  inherit
                    gruvbox-contrib
                    spacemacs
                    spacemacs-neuron
                    theme-bobthefish
                  ;
                };
              };
          })
        
          ./machines/desktop
          ./system
          ./users/isaac
          # Disabled to debug slow build times
          # ./users/work
        ];
      };    
    };
}
