{ ... }:

{
  services.displayManager.defaultSession = "xterm";
  services.libinput.enable = false;
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    synaptics.enable = true;
    desktopManager = {
      xterm.enable = true;
    };
    displayManager.lightdm = {
      enable = true;
      # Generated using https://github.com/lunik1/nix-wallpaper
      background = ./nix-wallpaper.png;
    };
  };
}
