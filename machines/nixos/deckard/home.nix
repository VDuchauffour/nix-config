{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = "${vars.user}";
  home.homeDirectory = "/home/${vars.user}";
  home.stateVersion = "25.05";

  home.packages = [];

  home.file = {
    ".config/nvim" = {
      source = ../../../users/${vars.user}/dots/astronvim;
      recursive = true;
    };
    ".config/lazygit" = {
      source = ../../../users/${vars.user}/dots/lazygit;
    };
    ".config/k9s" = {
      source = ../../../users/${vars.user}/dots/k9s;
      recursive = true;
    };
    ".config/ranger" = {
      source = ../../../users/${vars.user}/dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ../../../users/${vars.user}/dots/tmux/.tmux.conf;
    };

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

  imports = [
    ../../../users/${vars.user}/home/default.nix
  ];

  programs = {
    zsh =
      (import ../../../users/${vars.user}/home/zsh/default.nix {inherit vars;}).programs.zsh
      // {
        initContent =
          zsh_init_content
          + ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
          '';
      };
    nautilus = import ../../../users/${vars.user}/home/nautilus.nix;
  };

  xdg = {
    enable = true;
  };
}
