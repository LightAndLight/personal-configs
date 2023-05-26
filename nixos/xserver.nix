{ ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";
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
