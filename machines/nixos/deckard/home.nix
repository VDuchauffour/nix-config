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

  programs = {
    zsh = import ../../../users/${vars.user}/programs/zsh/default.nix {inherit vars;}.programs.zsh;
    nautilus = import ../../../users/${vars.user}/programs/nautilus.nix;
  };
}
