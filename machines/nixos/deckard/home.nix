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
    ".config/gtk-3.0" = {
      source = ../../../users/${vars.user}/dots/gtk/gtk-3.0;
      recursive = true;
    };
    ".config/gtk-4.0" = {
      source = ../../../users/${vars.user}/dots/gtk/gtk-4.0;
      recursive = true;
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

  services.udiskie.enable = true;

  services.gnome-keyring.enable = true;
  home.packages = [pkgs.gcr]; # Provides org.gnome.keyring.SystemPrompter

  xdg = {
    enable = true;
    portal = {
      extraPortals = with pkgs; [xdg-desktop-portal-hyprland gnome-keyring];
    };
  };
}
