{pkgs, ...}: {
  services.displayManager.ly.enable = true;
  services.displayManager.ly.settings = {
    animation = "colormix";
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar = {
    enable = true;
  };
}
