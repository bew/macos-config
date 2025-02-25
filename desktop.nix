{ pkgs, pkgsChannels, ... }:

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
    stable.flameshot # cross-platform screenshoting tool

    (pkgs.callPackage ./pkgs/hammerspoon.nix {})
  ];

  programs.hammerspoon.enable = true;
  system.defaults."org.hammerspoon.Hammerspoon" = {
    # FIXME: Remove hardcoded $HOME path!
    MJConfigFile = "/Users/benoitlesellierdechezelles/.config/hammerspoon/init.lua";
    MJKeepConsoleOnTopKey = true;
    MJShowMenuIconKey = true;
    MJShowDockIconKey = false;
  };
}
