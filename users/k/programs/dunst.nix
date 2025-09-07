{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 10";
        separator_height = 1;
        transparency = 0;
        width = "470";
        height = "90";
        # offset = "24x64";
        offset = "24x32";
        scale = 0;
        padding = 8;
        horizontal_padding = 8;
        notification_limit = 0;
        text_icon_padding = 0;
        corner_radius = 8;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = true;
        frame_width = 1;
        frame_color = "#44475a";
        separator_color = "#44475a";
        line_height = 0;
        markup = "full";
        alignment = "left";
        vertical_alignment = "center";
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 32;
        sort = "time";
        monitor = "primary";
        follow = "mouse";
        show_age_threshold = 60;
        # format = "%s\n%b";
        format = "<i>%a</i> - %s %p\n%b";
        sticky_history = true;
        history_length = 20;
        browser = "/run/current-system/sw/bin/xdg-open";
        always_run_script = true;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
        experimental_per_monitor_dpi = false;
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#f8f8f2";
        # frame_color = "#444444";
        timeout = 5;
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#f8f8f2";
        # frame_color = "#1c3e5e";
        timeout = 5;
      };
      urgency_critical = {
        background = "#ff5555";
        foreground = "#f8f8f2";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
