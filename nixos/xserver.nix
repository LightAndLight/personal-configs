{ ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = false;
    synaptics.enable = true;
    desktopManager = {
      xterm.enable = true;
    };
    displayManager = {
      defaultSession = "xterm";
      lightdm = {
        enable = true;
        # Generated using https://github.com/lunik1/nix-wallpaper
        background = ./nix-wallpaper.png;
      };
    };
  };
}
