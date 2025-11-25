{pkgs, ...}: {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal = {
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        gnome-keyring
      ];
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "papers.desktop";
      };
    };
  };
}
