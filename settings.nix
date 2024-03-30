{ config, pkgs, ... }: {
  options = with pkgs.lib; {
    settings = {
      isLaptop = mkOption {
       type = types.bool;
       default = false;
       description = "Enables laptop-related settings like battery levels and screen brightness";
      };

      dpi = mkOption {
       type = types.int;
       default = 284;
       description = "xresources DPI";
      };

      ergodox = mkOption {
       type = types.bool;
       default = true;
       description = "Whether or not I'm using my Ergodox EZ";
      };
    };
  };

  config = {
    services.upower.enable = config.settings.isLaptop;
    hardware.keyboard.zsa.enable = config.settings.ergodox;
  };
}
