{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    gruvbox-contrib = {
      url = "github:morhetz/gruvbox-contrib?rev=edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, home-manager, gruvbox-contrib }: {
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
                inherit gruvbox-contrib;
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
