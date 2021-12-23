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
      lightdm.enable = true;
    };
  };
}
