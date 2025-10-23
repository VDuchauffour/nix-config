{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to SUPER + P in the keybinds section below
        preserve_split = true; # you probably want this
        smart_split = true;
      };
    };
  };
}
