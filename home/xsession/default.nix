{ osConfig, pkgs, ... }: {
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config =
        pkgs.writeText
          "xmonad.hs"
          (import ./xmonad.hs.nix { fontSize = osConfig.fonts.size.pt_at_96dpi; });
      enableContribAndExtras = true;
    };
    initExtra = with pkgs; ''
      ${xorg.xset}/bin/xset -b
    '';
  };

  services.picom = {
    enable = true;

    # Required for properly rounded corners
    backend = "glx";

    settings = {
      corner-radius = 10;
    };
  };
}
