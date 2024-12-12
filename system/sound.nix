{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = [
    # https://discourse.nixos.org/t/no-audio-devices-with-pipewire-on-lenovo-x1-carbon-7th-gen/38966/6
    pkgs.sof-firmware

    pkgs.pavucontrol
  ];
}
