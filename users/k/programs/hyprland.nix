{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        ignore_empty_input = false;
        no_fade_in = true;
        no_fade_out = true;
      };

      background = {
        path = "screenshot";
        blur_passes = 4;
        blur_size = 4;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;

        fade_on_empty = false;

        font_family = "JetBrains Mono Nerd Font Mono";
        placeholder_text = "<span foreground=\"##cdd6f4\">Enter Password</span>";
        fail_text = "";

        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";

        fail_color = "rgb(D67C8E)"; # red
        capslock_color = "rgb(D6A37C)"; # orange

        shadow_passes = 1;
        shadow_size = 8;
        shadow_boost = 0.6;
      };
      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:60000] echo \"<span foreground=\'##ffffff\'>$(date \'+%H:%M\')</span>\"";
          color = "rgba(1,1,1,1.0)";
          font_size = 100;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          rotate = 0; # degrees, counter-clockwise

          position = "0, -200";
          text_align = "center";
          halign = "center";
          valign = "top";
        }
        # DATE
        {
          monitor = "";
          text = "cmd[update:60000] echo \"<span foreground=\'##ffffff\'>$(date \'+%a %d %b\')</span>\"";
          color = "rgba(1,1,1,1.0)";
          font_size = 30;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          rotate = 0; # degrees, counter-clockwise

          position = "0, -450";
          text_align = "center";
          halign = "center";
          valign = "top";
        }
      ];
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }
        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight.
        }
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
