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
  system.defaults.NSGlobalDomain."com.apple.trackpad.forceClick" = false;
  system.defaults.NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1; # enable corner click for right click
  # NOTE: If right click with 2-finger tap also clicks to targetting item, we can use 1-finger Ctrl-tap to get the menu.

  # WARN: even though this is set (and even when not set), the natural scroll direction resets to
  # DISABLED when applying the config, and I have to manually open Trackpad setting (where it's
  # still shown as enabled..) to toogle it twice (OFF then ON) again to have it applied
  # everywhere..
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true; # Natural Scroll!
  # After activation, auto-open Trackpad settings to force enable natural scrolling. 😬
  # note: We add to the existing `postActivation` fragment, that runs after everything
  system.activationScripts.postActivation.text = ''
    echo "Opening Trackpad settings to manually force enable natural scrolling.."
    open "x-apple.systempreferences:com.apple.Trackpad-Settings.extension"
  '';

  system.defaults.WindowManager.StandardHideDesktopIcons = true;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
  # NEVER let MacOS auto-re-arrange spaces based on recent apps used ><
  system.defaults.dock.mru-spaces = false;

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
