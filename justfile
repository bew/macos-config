_default:
  @just --summary

rebuild-and-diff *ARGS:
  #!/usr/bin/env bash
  set -e

  OLD=/run/current-system
  darwin-rebuild build --flake . {{ ARGS }}

  if [[ ! -e /run/current-system ]]; then
    echo "!! No previous system found (first build?) — skipping diff"
  elif ! command -v dix &>/dev/null; then
    echo "!! dix not found in PATH — skipping diff"
  else
    echo "Current system is: $(readlink "$OLD")"
    dix "$OLD" ./result
  fi

reswitch *ARGS:
  darwin-rebuild switch --flake . {{ ARGS }}
  # Force system settings to update
  # ref: https://github.com/LnL7/nix-darwin/issues/658
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
