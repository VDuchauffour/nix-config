{ pkgs, ... }: {
  enable = true;
  languagePacks = [ "fr" "en-US" ];
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

    ExtensionSettings = import ../common/gecko-addons.nix;

    Preferences = {
      "browser.contentblocking.category" = {
        Value = "strict";
        Status = "locked";
      };
      "extensions.pocket.enabled" = lock-false;
      "extensions.screenshots.disabled" = lock-false;
      "browser.topsites.contile.enabled" = lock-false;
      "browser.formfill.enable" = lock-false;
      "browser.search.suggest.enabled" = lock-false;
      "browser.search.suggest.enabled.private" = lock-false;
      "browser.urlbar.suggest.searches" = lock-false;
      "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
      "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
      "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
      "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
      "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
      "browser.newtabpage.activity-stream.showSponsored" = lock-false;
      "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      "browser.tabs.closeWindowWithLastTab" = lock-false;
      "sidebar.verticalTabs" = lock-true;
    };
  };
}
