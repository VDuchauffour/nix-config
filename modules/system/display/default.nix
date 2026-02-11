{pkgs, ...}: {
  # FIXME: remove overlay when nixpkgs fixes zig setup-hook
  # The zig setup-hook sets ZIG_GLOBAL_CACHE_DIR in configurePhase,
  # but ly's postPatch uses it before that, causing `ln -s ... /p` (permission denied).
  # This moves the symlink creation to postConfigure where the var is available.
  nixpkgs.overlays = [
    (final: prev: {
      ly = prev.ly.overrideAttrs (old: {
        postPatch = "";
        postConfigure = (old.postConfigure or "") + old.postPatch;
      });
    })
  ];

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

  # Workaround: explicitly define xdg-desktop-portal-gtk service
  # The auto-generated service shows as "bad" due to NixOS bug
  # systemd.user.services.xdg-desktop-portal-gtk = {
  #   description = "Portal service (GTK/GNOME implementation)";
  #   partOf = ["graphical-session.target"];
  #   after = ["graphical-session.target"];
  #   serviceConfig = {
  #     Type = "dbus";
  #     BusName = "org.freedesktop.impl.portal.desktop.gtk";
  #     ExecStart = "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk";
  #   };
  # };
}
