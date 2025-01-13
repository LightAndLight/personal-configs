{ inputs, config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    source-code-pro
    dejavu_fonts
    (pkgs.stdenv.mkDerivation {
      name = "powerline-fonts";
      src = inputs.powerline-fonts-src;
      installPhase = ''
        mkdir -p "$out/share/fonts/truetype/"
        cp DejaVuSansMono/*.ttf "$out/share/fonts/truetype/"
      '';
    })

    # Supports powerline by default.
    hack-font

    aileron
    nacelle
    inter
    source-sans
    source-serif
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Source Serif 4" ];
    sansSerif = [ "Source Sans 3" ];
    monospace = [ "Hack" ];
  };
}
