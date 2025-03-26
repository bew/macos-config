# The following basically corresponds to many calls to the `defaults` CLI tool
# (which is the Apple version of Microsoft registry)
# Good ref: https://www.real-world-systems.com/docs/defaults.1.html
# Nice set of configs: https://github.com/mathiasbynens/dotfiles/blob/master/.macos
{
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";

  # Allow moving window using Ctrl+Cmd+LeftDrag from anywhere
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;

  # Use F1, F2, etc. keys as standard function keys (use `fn+F#` for their alternate action)
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;

  # Disable various automatic text transformations
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  system.defaults.trackpad.Clicking = true; # tap-click
  system.defaults.trackpad.Dragging = true; # tap-drag
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false; # not natural 🙏
  system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = false;
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1; # enable corner click for right click
  # NOTE: If right click with 2-finger tap also clicks to targetting item, we can use 1-finger Ctrl-tap to get the menu.

  system.defaults.WindowManager.StandardHideDesktopIcons = true;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;

  # Apps settings

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
    QuitMenuItem = true; # Enable menu item to quit finder
  };

}
