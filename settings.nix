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
    };
  };

  config = {
    services.upower.enable = config.settings.isLaptop;
  };
}
