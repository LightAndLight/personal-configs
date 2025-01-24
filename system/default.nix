{
  imports = [
    ./display.nix
    ./fonts.nix
    ./home-manager.nix
    ./networking.nix
    ./packages.nix
    ./power.nix
    ./settings.nix
    ./ssh.nix
    ./sound.nix
    ./sync.nix
    ./virtualisation.nix
    ./xserver
  ];

  boot.tmp.cleanOnBoot = true;
}
