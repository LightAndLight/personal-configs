{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.isaac-nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
        }
        
        ./machines/desktop

        ./users/isaac
        # Disabled to debug slow build times
        # ./users/work

        ./fonts.nix
        ./packages.nix
        ./xserver.nix
        ./settings.nix
        ./sound.nix
      ];
    };    
  };
}
