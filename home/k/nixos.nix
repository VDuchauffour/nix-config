{
  config,
  lib,
  pkgs,
  ...
}: {
  home.file = {
    ".config/quickshell" = {
      source = ./dots/quickshell;
      recursive = true;
    };
  };
  # home.file = {
  #   ".config/waybar" = {
  #     source = ./dots/waybar;
  #     recursive = true;
  #   };
  # };
}
