{pkgs, ...}: {
  home.packages = with pkgs; [eog];
  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "org.gnome.eog.desktop";
    "image/png" = "org.gnome.eog.desktop";
    "image/tiff" = "org.gnome.eog.desktop";
    "image/bmp" = "org.gnome.eog.desktop";
    "image/gif" = "org.gnome.eog.desktop";
    "image/x-icon" = "org.gnome.eog.desktop";
    "image/svg+xml" = "org.gnome.eog.desktop";
    "image/webp" = "org.gnome.eog.desktop";
  };
}
