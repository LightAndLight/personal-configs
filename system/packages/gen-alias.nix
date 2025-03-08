{ stdenv, makeWrapper, gen-alias, GEN_ALIAS_HOST ? "id.ielliott.io" }:
stdenv.mkDerivation {
  name = "gen-alias-wrapped";
  src = gen-alias;
  buildInputs = [ makeWrapper ];
  buildPhase = "true";
  installPhase = ''
    mkdir -p $out
    ls -la
    cp -R bin $out/bin
    wrapProgram $out/bin/gen-alias --set GEN_ALIAS_HOST ${GEN_ALIAS_HOST}
  '';
}
