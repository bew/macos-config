_default:
  @just --summary

reswitch:
  nix run nix-darwin -- switch --flake .
  # Force system settings to update
  # ref: https://github.com/LnL7/nix-darwin/issues/658
  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
