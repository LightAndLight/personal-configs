{ pkgs, ... }: {
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ./xmonad.hs;
      enableContribAndExtras = true;
    };
    initExtra = with pkgs; ''
      ${xorg.xset}/bin/xset -b
    '';
  };  
}
