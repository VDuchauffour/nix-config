{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
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
