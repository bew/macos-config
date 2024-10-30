# The following basically corresponds to many calls to the `defaults` CLI tool
# (which is the Apple version of Microsoft registry)
# Good ref: https://www.real-world-systems.com/docs/defaults.1.html
# Nice set of configs: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
{
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  # Allow moving window using Ctrl+Cmd+LeftDrag from anywhere
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;

  # Disable various text automatic transformations
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = true;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = true;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = true;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = true;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = true;

  system.keyboard = {
    enableKeyMapping = true;
    # nonUS.remapTilde = true;
    remapCapsLockToEscape = true;
    swapLeftCtrlAndFn = true;
  };

  system.defaults.trackpad.Clicking = true; # tap-click
  system.defaults.trackpad.Dragging = true; # tap-drag

  system.defaults.dock = {
    autohide = true;
    tilesize = 30;
    magnification = true; # magnify on hover
    largesize = 38; # size of magnification
  };

  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true; # always show file extension (everywhere)
  system.defaults.finder = {
    FXPreferredViewStyle = "Nlsv"; # Nlsv: List view (details)
    _FXSortFoldersFirst = true; # keep folders on top
    ShowPathbar = true; # path breadcrumbs
    ShowStatusBar = false; # bar at bottom with item/disk space stats
  };

}
