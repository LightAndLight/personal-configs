{ inputs, ... }:
let
  substituters = [
    {
      url = "https://cache.nixos.org";
      publicKey = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    }
    {
      url = "https://cache.garnix.io";
      publicKey = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
    }
    {
      url = "https://srid.cachix.org";
      publicKey = "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI=";
    }
    {
      url = "https://nixcache.reflex-frp.org";
      publicKey = "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=";
    }
  ] ++ (import ./private-substituters.nix);
in
{
  nix.settings = {
    substituters = [ (builtins.head substituters).url ];
    trusted-substituters = builtins.map (x: x.url) substituters;
    trusted-public-keys = builtins.map (x: x.publicKey) substituters;
  };
}
