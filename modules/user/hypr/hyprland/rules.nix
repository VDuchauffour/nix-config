{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "float,class:^(pavucontrol)$,title:^(.*)$"
        "float,class:^(galculator)$,title:^(.*)$"
        "noblur,class:^()$,title:^()"
        "bordersize 2, floating:1" # only show borders on floating windows
        "size 1200 400, class:^(.protonvpn-app-wrapped)$"
      ];
    };
  };
}
