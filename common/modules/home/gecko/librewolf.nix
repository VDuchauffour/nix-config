{pkgs}: {
  enable = true;
  package = pkgs.librewolf;

  profiles.default = {
    id = 0;
    name = "Default";
    isDefault = true;
  };
  languagePacks = ["fr" "en-US"];

  policies = {
    SearchEngines = import ./search-engines.nix;
    ExtensionSettings = import ./addons.nix;
    ShowHomeButton = true;
  };

  settings = import ./preferences.nix;
}
