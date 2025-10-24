{ pkgs, pkgsChannels, config, ... }:

let
  inherit (pkgsChannels) stable;
in {
  imports = [
    ./modules/hammerspoon.nix
  ];

  # Add colored borders around windows to better highlight the active/inactive apps
  services.jankyborders = {
    enable = true;
    order = "above"; # improve visibility for maximized windows
    width = 4.0; # default: 5.0
    # Color format: 0xAARRGGBB
    inactive_color = "0xFF333333";
    active_color = "0xFF00AAAD"; # Teal
  };

  environment.systemPackages = [
    (pkgs.callPackage ./pkgs/hammerspoon.nix {})

    # nice clipboard manager
    (stable.maccy.overrideAttrs (prev: rec {
      version = "v2.5.1";
      src = pkgs.fetchurl {
        url = "https://github.com/p0deje/Maccy/releases/download/${version}/Maccy.app.zip";
        hash = "sha256-pwMiCAS+1uEtEQv2e1UflxYuuh/qqYJbMcp2ZVvZBTA=";
      };
    }))
  ];

  programs.hammerspoon.enable = true;
  system.defaults."org.hammerspoon.Hammerspoon" = {
    MJConfigFile = "/Users/${config.system.primaryUser}/.config/hammerspoon/init.lua";
    MJKeepConsoleOnTopKey = true;
    MJShowMenuIconKey = true;
    MJShowDockIconKey = false;
  };
}
