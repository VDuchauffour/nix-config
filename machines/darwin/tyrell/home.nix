{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  zsh_init_content = (import ../../../users/${vars.user}/programs/zsh/init-content.nix).initContent;
in {
  home.file = {
    ".aerospace.toml" = {
      source = ../../../users/${vars.user}/dots/aerospace/.aerospace.toml;
    };
  };

  programs.zsh =
    (import ../../../users/${vars.user}/programs/zsh/default.nix {inherit vars;}).programs.zsh
    // {
      initContent =
        zsh_init_content
        + ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
    };
}
