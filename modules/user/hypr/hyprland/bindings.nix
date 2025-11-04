{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$t1" = "ampersand";
      "$t2" = "eacute";
      "$t3" = "quotedbl";
      "$t4" = "apostrophe";
      "$t5" = "parenleft";

      "$terminal" = "alacritty";
      "$fileManager" = "nautilus";
      # "$menu" = "walker";
      "$menu" = "bash -c $HOME/.config/rofi/launchers/type-3/launcher.sh";
      "$screenshotEntireScreen" = "hyprshot -m output -m active -o ~/Pictures/Screenshots";
      "$screenshotWindow" = "hyprshot -m window -o ~/Pictures/Screenshots";

      bind = [
        # App shorcuts
        "SUPER, RETURN, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, F, exec, $fileManager"
        "SUPER, SPACE, exec, $menu"
        ", PRINT, exec, $screenshotEntireScreen"
        "SHIFT, PRINT, exec, $screenshotWindow"

        # Hyprland
        "SUPER CTRL ALT, R, exec, hyprctl reload"
        "SUPER CTRL ALT, Q, exec, pkill Hyprland"
        "SUPER CTRL, Q, exec, hyprlock"
        "SUPER CTRL ALT, F, fullscreen, 0"
        "SUPER, TAB, fullscreen, 1"
        # "SUPER, J, changegroupactive, f"
        # "SUPER, K, changegroupactive, b"
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
        "SUPER SHIFT, mouse:272, resizewindow"
      ];
    };
  };
}
