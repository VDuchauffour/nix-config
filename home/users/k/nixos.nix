{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
    ".config/gsimplecal" = {
      source = ./dots/gsimplecal/config;
    };
    ".config/libinput-gestures.conf" = {
      source = ./dots/libinput-gestures/libinput-gestures.conf;
    };
    ".config/rofi" = {
      source = ./dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./dots/waybar;
      recursive = true;
    };
  };

  imports = [
    ../../nixos
  ];
}
