{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./networking.nix
    ./packages.nix
    ./power.nix
    ./secrets.nix
    ./settings.nix
    ./ssh.nix
    ./sound.nix
    ./sync.nix
    ./ui.nix
    ./virtualisation.nix
    ./xscreensaver.nix
    ./xserver
  ];

  boot.tmp.cleanOnBoot = true;
}
