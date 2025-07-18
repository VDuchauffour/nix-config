{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = "${vars.user}";
  home.homeDirectory = "/Users/${vars.user}";
  home.stateVersion = "25.05";

  home.packages = [];

  home.file = {
    ".config/nvim" = {
      source = ../dots/astronvim;
      recursive = true;
    };
    ".config/lazygit" = {
      source = ../dots/lazygit;
    };
    ".config/k9s" = {
      source = ../dots/k9s;
      recursive = true;
    };
    ".config/ranger" = {
      source = ../dots/ranger;
      recursive = true;
    };
    ".tmux.conf" = {
      source = ../dots/tmux/.tmux.conf;
    };
  };

  programs = {
    zsh =
      import ../common/modules/home/zsh.nix
      // {
        initContent = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };
    starship = import ../common/modules/home/starship.nix;
    git = import ../common/modules/home/git.nix;
    direnv = import ../common/modules/home/direnv.nix;
    alacritty = import ../common/modules/home/alacritty.nix;
    bottom = import ../common/modules/home/bottom.nix;
    btop = import ../common/modules/home/btop.nix;
    firefox = import ../common/modules/home/gecko/firefox.nix;
    librewolf = import ../common/modules/home/gecko/librewolf.nix {pkgs = pkgs;};
  };

  xdg = {
    enable = true;
  };
}
