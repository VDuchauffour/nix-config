{pkgs, ...}: {
  services.display-manager.ly.enable = true;
  services.display-manager.ly.settings = {
    animation = "colormix";
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
