{pkgs, ...}: {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    portal.xdgOpenUsePortal = true;
    mime.enable = true;
    mimeApps.enable = true;
  };
}
