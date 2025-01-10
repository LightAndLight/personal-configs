{ stdenv, coreutils, ipso, pandoc }:
stdenv.mkDerivation {
  name = "mdpreview";

  src = ./src;
  buildPhase = "true";

  installPhase = ''
    mkdir -p $out

    cp mdpreview.ipso $out
    cp style.css $out

    mkdir $out/bin
    cat > $out/bin/mdpreview <<EOF
    #! /usr/bin/env bash

    # mktemp, dirname, basename
    export PATH="${coreutils}/bin"

    export MDPREVIEW_PANDOC="${pandoc}/bin/pandoc"
    export MDPREVIEW_STYLE="$out/style.css"
    ${ipso}/bin/ipso $out/mdpreview.ipso \$@
    EOF
    chmod +x $out/bin/mdpreview
  '';
}
