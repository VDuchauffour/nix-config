{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      decoration = {
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
    };
  };
}
