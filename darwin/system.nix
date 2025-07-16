{ vars }: {
  defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 12;
      KeyRepeat = 3;
    };
    CustomUserPreferences = {
      "com.microsoft.VSCode" = {
        "ApplePressAndHoldEnabled" = true;
      };
      # Disable creating .DS_Store files in network an USB volumes
      "com.apple.desktopservices" = {
        "DSDontWriteNetworkStores" = true;
        "DSDontWriteUSBStores" = true;
      };
      # Show battery percentage
      "/Users/${vars.user}/Library/Preferences/ByHost/com.apple.controlcenter.BatteryShowPercentage" = true;
      # Privacy
      com.apple.AdLib.allowApplePersonalizedAdvertising = false;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      autohide-time-modifier = 0.1;
      magnification = true;
      mineffect = "scale";
      minimize-to-application = true;
      orientation = "bottom";
      showhidden = false;
      show-recents = false;
      tilesize = 20;
      mru-spaces = false; # avoid automatically rearrange Spaces based on most recent use
    };
    finder = {
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
      # NewWindowTargetPath = "file:///Users/${vars.user}/"; # Set home directory as startup window
      NewWindowTarget = "Home";
      FXDefaultSearchScope = "SCcf"; # Set search scope to directory
    };
    loginwindow = {
      GuestEnabled = false;
      LoginwindowText = "k";
    };
    screencapture.location = "/Users/${vars.user}/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
