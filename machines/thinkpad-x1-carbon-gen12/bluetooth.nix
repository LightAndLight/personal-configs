{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.tlp.settings.DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";

  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
