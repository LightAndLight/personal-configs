{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./bluetooth.nix
      ../../system/substituters.nix
    ];

  home-manager.sharedModules = [ ./home.nix ];

  # Default for 24.11 is 6.6
  # `picom` was broken, and the 'net suggested that later kernel versions
  # might have better support for the Core Ultra 165U. Upgrading the kernel
  # seems to have worked.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "isaac-nixos-thinkpad-x1-carbon-gen12";
  services.openvpn.servers = {
    "nordvpn-us" = {
      config = "config ${../../system/us9866.nordvpn.com.tcp.ovpn}";
      autoStart = false;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  settings.isLaptop = true;
  settings.dpi = 162;
  fonts.size.mm = 2.1815;
  settings.hiDPI = true;

  hardware.graphics.enable = true;

  services.dbus.packages = [ pkgs.dconf ];

  time.timeZone = "Australia/Brisbane";

  i18n.defaultLocale = "en_US.UTF-8";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}

