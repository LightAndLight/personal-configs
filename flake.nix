{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    gruvbox-contrib = {
      url = "github:morhetz/gruvbox-contrib?rev=edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
      flake = false;
    };

    spacemacs = {
      url = "github:syl20bnr/spacemacs?ref=develop";
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

    powerline-fonts-src = {
      url = "github:powerline/fonts?rev=e80e3eba9091dac0655a0a77472e10f53e754bb0";
      flake = false;
    };

    columnize.url = "github:LightAndLight/columnize";

    xeval.url = "github:LightAndLight/xeval";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.isaac-nixos-desktop =
      let system = "x86_64-linux"; in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            system
            inputs
          ;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./machines/desktop
          ./system
          ./users/isaac
          ./users/work
        ];
      };

    nixosConfigurations.isaac-nixos-thinkpad-x1-carbon-gen12 =
      let system = "x86_64-linux"; in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            system
            inputs
          ;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./machines/thinkpad-x1-carbon-gen12
          ./system
          ./users/isaac
          ./users/work
        ];
      };

    nixosConfigurations.isaac-nixos-thinkpad =
      let system = "x86_64-linux"; in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            system
            inputs
          ;
        };
        modules = [
          home-manager.nixosModules.home-manager
          ./machines/thinkpad
          ./system
          ./users/isaac
        ];
      };
  };
}
