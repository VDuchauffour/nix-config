{pkgs, ...}: {
  system.gc = {
    automatic = true;
    date = "daily";
    options = "--delete-older-than 14d";
  };
  system.settings.auto-optimize-store = true;
}
