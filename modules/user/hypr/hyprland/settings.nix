{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      debug = {
        disable_logs = false;
      };

      ecosystem = {
        no_update_news = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      misc = {
        force_default_wallpaper = 1; # Set to 0 or 1 to disable the anime mascot wallpapers
      };

      source = "~/.config/hypr/monitors.conf";

      exec-once = [
        "hyprpaper"
        "hypridle"
        "hyprpm reload"
        "waybar &"
        "nm-applet &"
        "blueman-applet &"
        "udiskie &"
        "exec \"avizo-service\" &"
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ]; # change to qt6ct if you have that
    };
  };
}
