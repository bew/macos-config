_default:
  @just --summary

rebuild *ARGS:
  darwin-rebuild build --flake .#work-mac {{ ARGS }}

# Build & diff with current system
rebuild-and-diff *ARGS: (rebuild ARGS)
  #!/usr/bin/env bash
  set -e
  OLD=/run/current-system
  if [[ ! -e "$OLD" ]]; then
    echo "!! No previous system found (first build?) — skipping diff"
  elif ! command -v dix &>/dev/null; then
    echo "!! dix not found in PATH — skipping diff"
  else
    echo "Current system is: $(readlink "$OLD")"
    dix "$OLD" ./result
  fi

reswitch *ARGS: (rebuild ARGS)
  su adm3_bls -c 'sudo ./result/activate'
  # Force system settings to update
  # ref: https://github.com/LnL7/nix-darwin/issues/658
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
