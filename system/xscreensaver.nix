{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.xscreensaver ];
  services.xscreensaver.enable = true;
  security.pam.services.xscreensaver.enable = true;
}
