{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager?ref=release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gruvbox-contrib = {
      url = "github:morhetz/gruvbox-contrib?rev=edb3ee5f626cdfb250d5ab42c1f5ccb9f8050514";
      flake = false;
    };

    ipso = {
      url = "github:LightAndLight/ipso";
      inputs.flake-utils.follows = "flake-utils";
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

    columnize = {
      url = "github:LightAndLight/columnize";
      inputs.flake-utils.follows = "flake-utils";
    };

    xeval = {
      url = "github:LightAndLight/xeval";
      inputs.flake-utils.follows = "flake-utils";
    };

    gen-alias = {
      url = "github:LightAndLight/gen-alias";
      inputs.flake-utils.follows = "flake-utils";
    };

    rand = {
      url = "github:LightAndLight/rand";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    asker = {
      url = "github:LightAndLight/asker";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    syncthing-merge = {
      url = "github:LightAndLight/syncthing-merge";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    tsk = {
      url = "github:LightAndLight/tsk";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, ... }:
  let
    overlaysModule = {
      nixpkgs.overlays = [
        (self: super: {
          keepassxc = super.keepassxc.overrideDerivation (old: {
            patches = (old.patches or []) ++ [
              # https://github.com/keepassxreboot/keepassxc/pull/12236
              ./patches/keepassxc/allow-read-only-native-message-files.patch
            ];
          });
        })
        inputs.asker.overlays.default
        inputs.syncthing-merge.overlays.default
        inputs.tsk.overlays.default
      ];
    };

    commonModules = [
      overlaysModule
      home-manager.nixosModules.home-manager
      ./system
      ./users/isaac
      ./users/work
    ];
  in
  flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; }; in
    {
      devShells.default = pkgs.mkShell {
        shellHook = ''
          export PROJECT_ROOT=$(git rev-parse --show-toplevel)
        '';

        nativeBuildInputs = with pkgs; [
          age
          sops
        ];
      };
    }
  ) //
  {
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
        modules = commonModules ++ [
          ./machines/desktop
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
        modules = commonModules ++ [
          ./machines/thinkpad-x1-carbon-gen12
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
        modules = commonModules ++ [
          ./machines/thinkpad
        ];
      };
  };
}
