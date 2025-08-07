{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  zsh_init_content = (import ../../../users/${vars.user}/programs/zsh/init-content.nix).initContent;
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
      source = ../../../users/${vars.user}/dots/astronvim;
      recursive = true;
    };
    ".config/lazygit" = {
      source = ../../../users/${vars.user}/dots/lazygit;
    };
    ".config/ranger" = {
      source = ../../../users/${vars.user}/dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ../../../users/${vars.user}/dots/tmux/.tmux.conf;
    };

    ".aerospace.toml" = {
      source = ../../../users/${vars.user}/dots/aerospace/.aerospace.toml;
    };
  };

  imports = [
    ../../../users/${vars.user}/programs/default.nix
  ];

  programs.zsh =
    (import ../../../users/${vars.user}/programs/zsh/default.nix {inherit vars;}).programs.zsh
    // {
      initContent =
        zsh_init_content
        + ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
    };

  xdg = {
    enable = true;
  };
}
