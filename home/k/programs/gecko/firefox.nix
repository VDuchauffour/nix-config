{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
    };
    languagePacks = ["fr" "en-US"];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
      ShowHomeButton = true;

      profiles.default.search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
      };

      SearchEngines = import ./search-engines.nix;
      ExtensionSettings = import ./addons.nix;

      Preferences = import ./preferences.nix;
    };
  };
}
