{pkgs, ...}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar = {
    enable = true;
  };
}
