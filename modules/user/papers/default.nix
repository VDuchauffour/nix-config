{pkgs, ...}: {
  home.packages = with pkgs; [papers];
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "papers.desktop";
  };
}
