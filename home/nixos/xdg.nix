{pkgs, ...}: {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal = {
      extraPortals = with pkgs; [xdg-desktop-portal-hyprland gnome-keyring];
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
        "application/pdf" = "papers.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
        "image/png" = "org.gnome.eog.desktop";
        "image/tiff" = "org.gnome.eog.desktop";
        "image/bmp" = "org.gnome.eog.desktop";
        "image/gif" = "org.gnome.eog.desktop";
        "image/x-icon" = "org.gnome.eog.desktop";
        "image/svg+xml" = "org.gnome.eog.desktop";
        "image/webp" = "org.gnome.eog.desktop";
      };
    };
  };
}
