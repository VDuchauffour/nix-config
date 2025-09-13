{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  home.packages = [];

  home.file = {
    ".config/gsimplecal" = {
      source = ../../../users/${vars.userName}/dots/gsimplecal/config;
    };
    ".config/libinput-gestures.conf" = {
      source = ../../../users/${vars.userName}/dots/libinput-gestures/libinput-gestures.conf;
    };
    ".config/mpv" = {
      source = ../../../users/${vars.userName}/dots/mpv;
      recursive = true;
    };
    ".config/rofi" = {
      source = ../../../users/${vars.userName}/dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../../users/${vars.userName}/dots/waybar;
      recursive = true;
    };
  };

  services.udiskie.enable = true;

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
        "application/pdf" = "papers.desktop";
      };
    };
  };

  imports = [
    ../../../users/${vars.userName}/programs/hyprland
    ../../../users/${vars.userName}/programs/dunst.nix
  ];

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
