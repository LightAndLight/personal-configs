{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.isaac-nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/desktop
        ./default.nix
      ];
    };    
  };
}
