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

  services.udiskie.enable = true;

  services.gnome-keyring.enable = true;
  home.packages = [pkgs.gcr]; # Provides org.gnome.keyring.SystemPrompter

  xdg = {
    enable = true;
    portal = {
      extraPortals = with pkgs; [xdg-desktop-portal-hyprland gnome-keyring];
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
      };
    };
  };

  imports = [../../../users/${vars.user}/programs/hyprland];

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
  };
}
