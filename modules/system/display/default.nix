{pkgs, ...}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
}
