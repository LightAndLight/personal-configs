{ writeScriptBin, bash, scrot }:
writeScriptBin "scrap" ''
  #! ${bash}/bin/bash

  mkdir -p "$HOME"/screenshots
  ${scrot}/bin/scrot -F "$HOME"'/screenshots/%Y-%m-%dT%H:%M:%S_scrot_$wx$h.png' --format png -s -f
''
