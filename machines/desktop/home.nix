{ lib, ... }: {
  options.programs.firefox.profiles = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
      config.settings = {
        "layout.css.devPixelsPerPx" = 1.0;
      };
    }));
  };
}
