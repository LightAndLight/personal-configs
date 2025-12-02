{ writeScriptBin, nushell, curl, pup }:
writeScriptBin "mdlink" ''
#! /usr/bin/env sh

PATH="${curl}/bin:${pup}/bin:$PATH" exec ${nushell}/bin/nu --stdin ${./mdlink.nu}
''
