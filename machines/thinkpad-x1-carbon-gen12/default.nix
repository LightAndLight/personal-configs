{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../system/substituters.nix
    ];

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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  settings.isLaptop = true;
  settings.hiDPI = false;

  # xrandr -q
  # 1920px x 1080px, 309mm x 173mm
  # 1920/(309/22.5) ~= 1080/(173/22.5) ~= 140px/in
  settings.dpi = 144;

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

