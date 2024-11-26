{ writeScriptBin }:
writeScriptBin "slowly" ''
#! /usr/bin/env bash
set -u

systemd-run --user --scope -p CPUQuota=$CPU -- taskset -c $CORES "$@"
''
