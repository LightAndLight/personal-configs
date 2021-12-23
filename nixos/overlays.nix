let
  unstable-20200404 =
    import (builtins.fetchGit {
      name = "nixos-unstable-20200404";
        url = https://github.com/nixos/nixpkgs-channels/;
        ref = "refs/heads/nixos-unstable";
        # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
        rev = "683c68232e91f76386db979c461d8fbe2a018782";
    })
    {};
in
  [
    (self: super: {
      haskellPackages =
        super.haskellPackages.override {
          overrides = old: new: {
            taffybar = unstable-20200404.haskellPackages.taffybar;
          };
        };
    })
  ]
