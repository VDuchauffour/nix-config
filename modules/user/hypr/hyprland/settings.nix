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

      source = "~/.config/hypr/monitors.conf";

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
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

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Set programs that you use
      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      "$menu" = "bash -c $HOME/.config/rofi/launchers/type-3/launcher.sh";

      # Some default env vars.
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ]; # change to qt6ct if you have that

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        # col.active_border = "rgba(f8f8f2ee)";
        # col.inactive_border = "rgba(0b0f12aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        # resize_on_border = true;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 7;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        shadow = {
          enabled = true;
          range = 5;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 0%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to SUPER + P in the keybinds section below
        preserve_split = true; # you probably want this
        smart_split = true;
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        # new_is_master = true
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      #
      # TODO
      # device:epic-mouse-v1 {
      #     sensitivity = -0.5
      # }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      windowrulev2 = [
        "float,class:^(pavucontrol)$,title:^(.*)$"
        "float,class:^(galculator)$,title:^(.*)$"
        "noblur,class:^()$,title:^()"
        "bordersize 2, floating:1" # only show borders on floating windows
        "size 1200 400, class:^(.protonvpn-app-wrapped)$"
      ];
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      #
      # TODO
      # windowrulev2 = nomaximizerequest, class:.* # You'll probably like this.

      gesture = [
        "3, horizontal, workspace"
      ];

      "$t1" = "ampersand";
      "$t2" = "eacute";
      "$t3" = "quotedbl";
      "$t4" = "apostrophe";
      "$t5" = "parenleft";
    };
  };
}
