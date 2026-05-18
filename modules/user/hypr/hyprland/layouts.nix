{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        preserve_split = true; # you probably want this
        smart_split = true;
      };
    };
  };
}
