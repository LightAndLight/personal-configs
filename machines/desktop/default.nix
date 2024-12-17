{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../system/substituters.nix
    ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  networking.hostName = "isaac-nixos-desktop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  settings.dpi = 192;
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # https://nixos.org/manual/nixos/stable/release-notes#sec-release-22.11-highlights (`hardware.nvidia`)
    #
    # https://developer.nvidia.com/blog/nvidia-releases-open-source-gpu-kernel-modules/
    open = true;

    # Stops my monitor from disconnecting when I log out / quit Xmonad.
    nvidiaPersistenced = true;
  };

  services.dbus.packages = [ pkgs.dconf ];

  virtualisation.docker.enable = true;
  
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  time.timeZone = "Australia/Brisbane";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_GB.UTF-8";
    };
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno2.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

