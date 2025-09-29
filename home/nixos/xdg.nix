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
      };
    };
  };
}
