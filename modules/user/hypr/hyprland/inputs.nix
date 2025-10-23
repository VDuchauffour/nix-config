{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
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
          disable_while_typing = false;
          tap-to-click = true;
          natural_scroll = true;
          scroll_factor = 1.25;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };
    };
  };
}
