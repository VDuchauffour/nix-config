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

  programs = {
    zsh =
      import ../../../nix/home/zsh.nix
      // {
        initContent = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };
    starship = import ../../../nix/home/starship.nix;
    git = import ../../../nix/home/git.nix;
    direnv = import ../../../nix/home/direnv.nix;
    alacritty = import ../../../nix/home/alacritty.nix;
    bottom = import ../../../nix/home/bottom.nix;
    btop = import ../../../nix/home/btop.nix;
    firefox = import ../../../nix/home/gecko/firefox.nix;
    librewolf = import ../../../nix/home/gecko/librewolf.nix {pkgs = pkgs;};
    # nautilus = import ../../../nix/home/nautilus.nix;
  };

  xdg = {
    enable = true;
  };
}
