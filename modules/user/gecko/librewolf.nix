{
  programs.librewolf = {
    enable = true;

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
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";
    "x-scheme-handler/about" = "librewolf.desktop";
    "x-scheme-handler/unknown" = "librewolf.desktop";
  };
}
