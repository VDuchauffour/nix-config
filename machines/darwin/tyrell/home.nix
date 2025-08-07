{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  zsh_config = import ../../../nix/home/zsh.nix {inherit vars;};
in {
  programs.home-manager.enable = true;

  home.username = "${vars.user}";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${vars.user}"
    else "/home/${vars.user}";
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
    ".config/ranger" = {
      source = ../../../dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ../../../dots/tmux/.tmux.conf;
    };

    ".aerospace.toml" = {
      source = ../../../dots/aerospace/.aerospace.toml;
    };
  };

  programs = {
    zsh =
      zsh_config
      // {
        initContent = lib.concatLines [
          zsh_config.initContent
          ''
            eval "$(/opt/homebrew/bin/brew shellenv)"
          ''
        ];
      };
    starship = import ../../../nix/home/starship.nix;
    git = import ../../../nix/home/git.nix;
    direnv = import ../../../nix/home/direnv.nix;
    alacritty = import ../../../nix/home/alacritty.nix;
    bottom = import ../../../nix/home/bottom.nix;
    btop = import ../../../nix/home/btop.nix;
    k9s = import ../../../nix/home/k9s.nix;
    firefox = import ../../../nix/home/gecko/firefox.nix;
    librewolf = import ../../../nix/home/gecko/librewolf.nix {pkgs = pkgs;};
  };

  xdg = {
    enable = true;
  };
}
