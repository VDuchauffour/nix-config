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
}
