{pkgs, ...}: {
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    OZONE_PLATFORM = "wayland";
    OZONE_PLATFORM_HINT = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
    # WAYLAND_DISPLAY = "wayland-0";
    # MOZ_ENABLE_WAYLAND = "1";
    # ELECTRON_ENABLE_WAYLAND = "1";
  };
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      session_log = ".ly-session.log";
    };
  };
  security.pam.services.ly.fprintAuth = false;
  security.pam.services.hyprlock.fprintAuth = false;

  xdg.autostart.enable = true;
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
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
        "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        "org.freedesktop.impl.portal.OpenURI" = ["hyprland"];
      };
    };
    extraPortals = [pkgs.xdg-desktop-portal pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
  };
}
