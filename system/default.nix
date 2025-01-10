{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./networking.nix
    ./packages.nix
    ./power.nix
    ./settings.nix
    ./sound.nix
    ./virtualisation.nix
    ./xserver
  ];

  boot.tmp.cleanOnBoot = true;
}
