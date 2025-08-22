{ inputs, config, pkgs, ... }:
{
  options = with pkgs.lib; {
    fonts = {
      size = mkOption {
        type = types.oneOf [types.float types.int];
        default = 12;
        description = "System font size, in points";
      };
    };
  };

  config = {
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
