{ vars
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
    zsh = {
      enable = true;
      initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        eval "$(direnv hook zsh)"
      '';
    };
  };
}
