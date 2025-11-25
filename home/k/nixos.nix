{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
    ".config/waybar" = {
      source = ./dots/waybar;
      recursive = true;
    };
  };
}
