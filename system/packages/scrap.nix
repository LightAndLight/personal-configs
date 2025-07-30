{ writeScriptBin, bash, scrot, xclip }:
writeScriptBin "scrap" ''
  #! ${bash}/bin/bash

  ${scrot}/bin/scrot -z -F - --format png -s -f |
    ${xclip}/bin/xclip -selection clip -t image/png
''
