{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = "${vars.userName}";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${vars.userName}"
    else "/home/${vars.userName}";
  home.stateVersion = "25.11";

  home.file = {
    ".config/nvim" = {
      source = ./dots/astronvim;
      recursive = true;
    };
  };

  xdg.enable = true;
}
