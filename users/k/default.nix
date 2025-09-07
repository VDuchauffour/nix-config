{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
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
      source = ./dots/astronvim;
      recursive = true;
    };
    ".config/lazygit" = {
      source = ./dots/lazygit;
    };
    ".config/ranger" = {
      source = ./dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ./dots/tmux/.tmux.conf;
    };
  };

  imports = [
    ./programs/default.nix
  ];

  programs.zsh = (import ./programs/zsh/default.nix {inherit vars pkgs;}).programs.zsh;

  xdg.enable = true;
}
