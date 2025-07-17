let
  preferences = {
    "browser.contentblocking.category" = "strict";
    "extensions.pocket.enabled" = false;
    "privacy.resistFingerprinting" = true;
    "extensions.screenshots.disabled" = false;
    "browser.topsites.contile.enabled" = false;
    "browser.formfill.enable" = false;
    "browser.search.suggest.enabled" = false;
    "browser.search.suggest.enabled.private" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.showSearchSuggestionsFirst" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.snippets" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
    "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.system.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.tabs.closeWindowWithLastTab" = false;
    "identity.fxaccounts.enabled" = false;
    "sidebar.verticalTabs" = true;
    "sidebar.main.tools" = "";
    "sidebar.visibility" = "always-show";
  };
in {
  enable = true;
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

    SearchEngines = {
      Default = "DuckDuckGo";
      SearchSuggestEnabled = false;
      Remove = ["Google" "Bing" "Amazon.com" "eBay" "Wikipedia"];
      PreventInstalls = false;
      Add = [
        {
          Name = "DuckDuckGo";
          URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
          Alias = "ddgr";
        }
        {
          Name = "Google";
          URLTemplate = "https://google.com/?q={searchTerms}";
          Alias = "google";
        }
      ];
    };

    ExtensionSettings = import ../gecko-addons.nix;

    Preferences =
      builtins.mapAttrs (_key: val: {
        Status = "locked";
        Value = val;
      })
      preferences;
  };
}
