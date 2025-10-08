{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
    ".config/rofi" = {
      source = ./dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./dots/waybar;
      recursive = true;
    };
  };
}
