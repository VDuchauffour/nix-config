{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  home.file = {
    ".config/gsimplecal" = {
      source = ../../../home/${vars.userName}/dots/gsimplecal/config;
    };
    ".config/libinput-gestures.conf" = {
      source = ../../../home/${vars.userName}/dots/libinput-gestures/libinput-gestures.conf;
    };
    ".config/rofi" = {
      source = ../../../home/${vars.userName}/dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../../home/${vars.userName}/dots/waybar;
      recursive = true;
    };
  };

  services.udiskie.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
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
    ../../../home/${vars.userName}/programs/hyprland
    ../../../home/${vars.userName}/programs/dunst.nix
  ];

  fonts = {
    fontconfig = {
      enable = true;
      # defaultFonts = {
      #   emoji = ["Noto Color Emoji"];
      #   monospace = ["MesloLGL Nerd Font Mono"];
      #   sansSerif = ["MesloLGL Nerd Font"];
      #   serif = ["Times New Roman"];
      # };
    };
  };

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
