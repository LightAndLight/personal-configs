{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.substituters = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org"
      "https://uptrust.cache.smithy.build"
    ];
    settings.trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "smithy-uptrust-1:hPyLtJbpoWoF9cg8MNhFQdPkLYvBOz1RX6u2X2On5Kg="
    ];
  };

  networking.hostName = "isaac-nixos-thinkpad";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  settings.isLaptop = true;
  settings.hiDPI = false;

  # xrandr -q
  # 1920px x 1080px, 309mm x 173mm
  # 1920/(309/22.5) ~= 1080/(173/22.5) ~= 140px/in
  settings.dpi = 144;

  hardware.opengl.enable = true;

  services.dbus.packages = [ pkgs.dconf ];

  virtualisation.docker.enable = false;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  time.timeZone = "Australia/Brisbane";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp4s0.useDHCP = true;

  i18n.defaultLocale = "en_US.UTF-8";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

