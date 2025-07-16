{ vars
, pkgs
, ...
}: {
  home.username = "${vars.user}";
  home.homeDirectory = "/Users/${vars.user}";
  home.stateVersion = "25.05";

  # User specific applications
  home.packages = [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
  };

  programs.home-manager.enable = true;

  programs = {
    zsh = import ../common/modules/home/zsh.nix { inherit pkgs; } // {
      initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        eval "$(direnv hook zsh)"
      '';
    };
    git = import ../common/modules/home/git.nix { inherit pkgs; };
    direnv = import ../common/modules/home/direnv.nix { inherit pkgs; };
    alacritty = import ../common/modules/home/alacritty.nix { inherit pkgs; };
    firefox = import ../common/modules/home/firefox.nix { inherit pkgs; };
    bottom = import ../common/modules/home/bottom.nix { inherit pkgs; };
    btop = import ../common/modules/home/btop.nix { inherit pkgs; };
    librewolf = import ../common/modules/home/librewolf.nix { inherit pkgs; };
  };
}
