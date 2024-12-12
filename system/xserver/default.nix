{ ... }:

{
  services.displayManager.defaultSession = "xterm";
  services.libinput = {
    enable = true;
    touchpad = {
      scrollMethod = "twofinger";
      naturalScrolling = true;
    };
  };
  services.xserver = {
    enable = true;
    xkb.layout = "us";
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
