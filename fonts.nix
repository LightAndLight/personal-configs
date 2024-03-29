{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    source-code-pro
    dejavu_fonts
    (pkgs.stdenv.mkDerivation {
      name = "powerline-fonts";
      src = pkgs.fetchFromGitHub {
        owner = "powerline";
        repo = "fonts";
        rev = "e80e3eb";
        sha256 = "sha256-GGfON6Z/0czCUAGxnqtndgDnaZGONFTU9/Hu4BGDHlk=";
      };
      installPhase = ''
        mkdir -p "$out/share/fonts/truetype/"
        cp DejaVuSansMono/*.ttf "$out/share/fonts/truetype/"
      '';
    })
  ];
}
