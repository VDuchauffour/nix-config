{vars}: {
  defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 12;
      KeyRepeat = 3;
      "com.apple.trackpad.scaling" = 2.0;
    };
    trackpad = {
      Clicking = true;
      ActuationStrength = 0;
      TrackpadThreeFingerDrag = false;
    };
    CustomUserPreferences = {
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = false;
        _FXSortFoldersFirst = true;
        FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
      };
      # Cursor
      "com.todesktop.230313mzl4w4u92" = {
        "ApplePressAndHoldEnabled" = false;
      };
      "com.microsoft.VSCode" = {
        "ApplePressAndHoldEnabled" = false;
      };
      # Disable creating .DS_Store files in network an USB volumes
      "com.apple.desktopservices" = {
        "DSDontWriteNetworkStores" = true;
        "DSDontWriteUSBStores" = true;
      };
      # Show battery percentage
      controlcenter.BatteryShowPercentage = true;
      # Privacy
      com.apple.AdLib.allowApplePersonalizedAdvertising = false;
    };
    dock = {
      autohide = true;
      autohide-delay = 0.2;
      autohide-time-modifier = 0.1;
      magnification = true;
      mineffect = "scale";
      largesize = 64;
      minimize-to-application = true;
      orientation = "bottom";
      showhidden = false;
      show-recents = false;
      tilesize = 20;
      mru-spaces = false; # avoid automatically rearrange Spaces based on most recent use
      persistent-apps = [
        {
          app = "/Applications/Alacritty.app";
        }
      ];
      persistent-others = [];
    };
    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };
    controlcenter = {
      BatteryShowPercentage = false;
      NowPlaying = false;
      Sound = true;
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
