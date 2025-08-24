{ lib, osConfig, ... }: {
  options = {
    programs = {
      firefox.profiles = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
          config.settings = {
            # Ideally, all of Firefox would be scaled according to some base
            # physical unit (such as the system font size), so that I could
            # make it perceptually uniform across devices.
            #
            # Unfortunately, I couldn't figure out how to scale the UI at
            # while keeping text perceptually uniform. So I've decided that
            # inconsistent UI scaling is the lesser evil.

            # "layout.css.devPixelsPerPx" = 0.779;
          };
        }));
      };

      thunderbird.profiles = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
          config.settings = {
            # "layout.css.devPixelsPerPx" =
              # Thunderbird config parsing has a bug: it reports a syntax error
              # if we use a decimal literal.
              # builtins.toString 0.779;
          };
        }));
      };
    };
  };
}
