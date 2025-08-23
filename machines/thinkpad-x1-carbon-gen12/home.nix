{ lib, ... }: {
  options = {
    programs = {
      firefox.profiles = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
          config.settings = {
            "layout.css.devPixelsPerPx" = 0.846;
          };
        }));
      };

      thunderbird.profiles = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule ({ config, ... }: {
          config.settings = {
            "layout.css.devPixelsPerPx" =
              # Thunderbird config parsing has a bug: it reports a syntax error
              # if we use a decimal literal.
              builtins.toString 0.846;
          };
        }));
      };
    };
  };
}
