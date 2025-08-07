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
      source = ../../../dots/astronvim;
      recursive = true;
    };
    ".config/lazygit" = {
      source = ../../../dots/lazygit;
    };
    ".config/k9s" = {
      source = ../../../dots/k9s;
      recursive = true;
    };
    ".config/ranger" = {
      source = ../../../dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ../../../dots/tmux/.tmux.conf;
    };

    ".config/dunst" = {
      source = ../../../dots/dunst/dunstrc;
    };
    ".config/gsimplecal" = {
      source = ../../../dots/gsimplecal/config;
    };
    ".config/hypr" = {
      source = ../../../dots/hypr;
      recursive = true;
    };
    ".config/libinput-gestures.conf" = {
      source = ../../../dots/libinput-gestures/libinput-gestures.conf;
    };
    ".config/mpv" = {
      source = ../../../dots/mpv;
      recursive = true;
    };
    ".config/rofi" = {
      source = ../../../dots/rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../../dots/waybar;
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
