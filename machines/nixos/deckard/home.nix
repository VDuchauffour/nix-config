{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  home.file = {
    ".config/dunst" = {
      source = ../../../users/${vars.user}/dots/dunst/dunstrc;
    };
    ".config/gsimplecal" = {
      source = ../../../users/${vars.user}/dots/gsimplecal/config;
    };
    ".config/hypr" = {
      source = ../../../users/${vars.user}/dots/hypr;
      recursive = true;
    };
    ".config/libinput-gestures.conf" = {
      source = ../../../users/${vars.user}/dots/libinput-gestures/libinput-gestures.conf;
    };
    ".config/mpv" = {
      source = ../../../users/${vars.user}/dots/mpv;
      recursive = true;
    };
    ".config/rofi" = {
      source = ../../../users/${vars.user}/dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../../users/${vars.user}/dots/waybar;
      recursive = true;
    };
  };

  # programs = {
  #   nautilus = import ../../../users/${vars.user}/programs/nautilus.nix;
  # };
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
  };
}
