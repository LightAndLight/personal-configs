{ inputs, config, pkgs, ... }:
{
  options = with pkgs.lib; {
    fonts.size.mm = mkOption {
      type = types.oneOf [types.float types.int];
      description = "System font size, in millimeters";
    };

    fonts.size.px = mkOption {
      type = types.oneOf [types.float types.int];
      description = "System font size, in (physical) pixels (read-only)";
      readOnly = true;
    };

    fonts.size.pt_at_96dpi = mkOption {
      type = types.oneOf [types.float types.int];
      description = ''
        System font size, in "logical" points (read-only)

        Many programs use points as a physical size by converting them to pixels using
        a DPI of 96: `ptToPx x = x * (1/72) * 96`. This option uses `fonts.size.mm` to
        compute a corresponding size in "logical" points suitable for such programs.
      '';
      readOnly = true;
    };
  };

  config = {
    assertions = [
      {
        assertion = config.fonts.size.mm > 0;
        message = "fonts.size.mm must be greater than 0";
      }
      {
        assertion = config.fonts.size.px > 0;
        message = "fonts.size.px must be greater than 0";
      }
      {
        assertion = config.fonts.size.pt_at_96dpi > 0;
        message = "fonts.size.pt_at_96dpi must be greater than 0";
      }
    ];

    fonts.size.px =
      config.fonts.size.mm # mm
      * (1.0 / 25.4) # in/mm
      * config.settings.dpi # px/in
    ;

    fonts.size.pt_at_96dpi =
      config.fonts.size.px # px
      * (1.0 / 96.0) # in/px
      * 72.0 # pt/in
    ;

    fonts.packages = with pkgs; [
      caladea # Cambria replacement
      carlito # Calibri replacement
      dejavu_fonts
      gelasio # Georgia replacement
      hack-font # Supports powerline by default
      libertine
      source-sans
      source-han-sans
      source-serif

      (pkgs.stdenv.mkDerivation {
        name = "powerline-fonts";
        src = inputs.powerline-fonts-src;
        installPhase = ''
          mkdir -p "$out/share/fonts/truetype/"
          cp DejaVuSansMono/*.ttf "$out/share/fonts/truetype/"
        '';
      })
    ];

    fonts.fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <alias binding="same">
            <family>Linux Libertine</family>
            <accept>
              <family>Linux Libertine O</family>
            </accept>
          </alias>
        </fontconfig>
      '';

      defaultFonts = {
        serif = [ "Source Serif 4" ];
        sansSerif = [ "Source Sans 3" ];
        monospace = [ "Hack" ];
      };
    };
  };
}
