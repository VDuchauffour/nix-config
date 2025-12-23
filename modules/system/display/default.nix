{pkgs, ...}: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    OZONE_PLATFORM = "wayland";
    OZONE_PLATFORM_HINT = "wayland";
    # WAYLAND_DISPLAY = "wayland-0";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_ENABLE_WAYLAND = "1";
  };
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      session_log = ".ly-session.log";
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar = {
    enable = true;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
  };
}
