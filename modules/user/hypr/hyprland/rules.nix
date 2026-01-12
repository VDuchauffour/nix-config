{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        {
          "name" = "floating-pavucontrol-rule";
          "match:class" = "org.pulseaudio.pavucontrol";
          "float" = "on";
        }
        {
          "name" = "floating-gnome-calculator-rule";
          "match:class" = "org.gnome.Calculator";
          "float" = "on";
        }
        {
          "name" = "floating-protonvpn-rule";
          "match:class" = "protonvpn-app";
          "float" = "on";
        }
        # {
        #   "name" = "sizing-protonvpn-rule";
        #   "match:class" = "protonvpn-app";
        #   "size" = "1200 400";
        # }
        # "noblur,class:^()$,title:^()"
        # "bordersize 2, floating:1" # only show borders on floating windows
      ];
      layerrule = [
        {
          "name" = "vicinae-rule";
          "blur" = "on";
          "ignore_alpha" = 0;
          "match:namespace" = "vicinae";
        }
        {
          "name" = "vicinae-disable-animation-rule";
          "no_anim" = "on";
          "match:namespace" = "vicinae";
        }
      ];
    };
  };
}
