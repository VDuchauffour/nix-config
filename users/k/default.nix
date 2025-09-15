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
  home.stateVersion = "25.05";

  home.packages = [];

  home.file = {
    ".config/nvim" = {
      source = ./dots/astronvim;
      recursive = true;
    };
    ".config/ranger" = {
      source = ./dots/ranger;
      recursive = true;
    };
  };

  imports = [
    ./programs
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
