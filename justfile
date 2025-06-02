_default:
  @just --summary

rebuild *ARGS:
  darwin-rebuild build --flake . {{ ARGS }}

reswitch *ARGS:
  darwin-rebuild switch --flake . {{ ARGS }}
  # Force system settings to update
  # ref: https://github.com/LnL7/nix-darwin/issues/658
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
