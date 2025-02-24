{ pkgs, ... }:

{
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
    # note: config is in `~/.hammerspoon`
    (pkgs.callPackage ./pkgs/hammerspoon.nix {})
  ];
  # FIXME: Remove hardcoded $HOME path!
  system.defaults."org.hammerspoon.Hammerspoon".MJConfigFile = "/Users/benoitlesellierdechezelles/.config/hammerspoon/init.lua";
}
