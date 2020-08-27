{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./home.nix
    ./packages.nix
    ./xserver.nix
  ];

  options = with pkgs.lib; {
    settings.isLaptop = mkOption {
      type = types.bool;
      default = false;
      description = "Enables laptop-related settings like battery levels and screen brightness";
    };
  };

  config = {
    services.upower.enable = config.settings.isLaptop;
  };
}
