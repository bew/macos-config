_default:
  @just --summary

rebuild *ARGS:
  nix run nix-darwin -- build --flake . {{ ARGS }}

reswitch *ARGS:
  nix run nix-darwin -- switch --flake . {{ ARGS }}
  # Force system settings to update
  # ref: https://github.com/LnL7/nix-darwin/issues/658
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
