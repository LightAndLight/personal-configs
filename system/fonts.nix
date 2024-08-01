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
  ];
}
