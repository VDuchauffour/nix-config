{ pkgs, ... }: {
  enable = true;
  languagePacks = [ "fr" "en-US" ];
  policies = {
    ExtensionSettings = import ../common/gecko-addons.nix;
  };
  settings = {
    "webgl.disabled" = false;
    "privacy.resistFingerprinting" = false;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.cookies" = false;
    "network.cookie.lifetimePolicy" = 0;
    "browser.tabs.closeWindowWithLastTab" = false;
    "sidebar.verticalTabs" = true;
  };
}
