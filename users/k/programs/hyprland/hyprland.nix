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

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input = {
        kb_layout = "fr";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        repeat_delay = 250;
        repeat_rate = 25;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 1.25;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

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

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
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
      ];
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      #
      # TODO
      # windowrulev2 = nomaximizerequest, class:.* # You'll probably like this.

      "$t1" = "ampersand";
      "$t2" = "eacute";
      "$t3" = "quotedbl";
      "$t4" = "apostrophe";
      "$t5" = "parenleft";

      bind = [
        # App shorcuts
        "SUPER, RETURN, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, F, exec, $fileManager"
        "SUPER, SPACE, exec, $menu"

        # Hyprland
        "SUPER CTRL ALT, R, exec, hyprctl reload"
        "SUPER CTRL ALT, Q, exec, pkill Hyprland"
        "SUPER CTRL, Q, exec, hyprlock"
        "SUPER CTRL ALT, F, fullscreen, 0"
        "SUPER, TAB, fullscreen, 1"
        # "SUPER, J, changegroupactive, f"
        # "SUPER, K, changegroupactive, b"
        "SUPER CTRL ALT, F, togglefloating"
        # "SUPER, J, togglesplit" # dwindle

        # Move focus with SUPER + arrow keys
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Move window
        "SUPER CTRL, H, movewindow, l"
        "SUPER CTRL, l, movewindow, r"
        "SUPER CTRL, J, movewindow, d"
        "SUPER CTRL, K, movewindow, u"

        # Switch workspaces
        "SUPER ALT, H, workspace, -1"
        "SUPER ALT, L, workspace, +1"

        "SUPER CTRL ALT, H, focusmonitor, -1"
        "SUPER CTRL ALT, L, focusmonitor, +1"

        # Move active window to a workspace with SUPER + SHIFT + [0-9]
        "SUPER CTRL, $t1, movetoworkspace, 1"
        "SUPER CTRL, $t2, movetoworkspace, 2"
        "SUPER CTRL, $t3, movetoworkspace, 3"
        "SUPER CTRL, $t4, movetoworkspace, 4"
        "SUPER CTRL, $t5, movetoworkspace, 5"

        # Example special workspace (scratchpad)
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with SUPER + scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # Screenshot
        ", PRINT, exec, grim -o $(hyprctl monitors | grep -B 12 'focused: yes' | grep 'Monitor' | awk '{ print $2 }') -t jpeg ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%m-%s).jpg"
      ];

      # Brightness
      bindel = [
        ",XF86MonBrightnessUp, exec, lightctl up"
        ",XF86MonBrightnessDown, exec, lightctl down"

        # Media
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioLowerVolume, exec, volumectl -u down"
      ];
      bindl = [
        ", XF86AudioMute, exec, volumectl toggle-mute"
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];

      # Resize window
      binde = [
        "SUPER SHIFT, H, resizeactive, -35 0"
        "SUPER SHIFT, L, resizeactive, 35 0"
        "SUPER SHIFT, K, resizeactive, 0 -35"
        "SUPER SHIFT, J, resizeactive, 0 35"

        "SUPER SHIFT, left, resizeactive, -35 0"
        "SUPER SHIFT, right, resizeactive, 35 0"
        "SUPER SHIFT, up, resizeactive, 0 -35"
        "SUPER SHIFT, down, resizeactive, 0 35"
      ];

      # Mouse
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # bind = SUPER, T, overview:toggle
    };
  };
}
