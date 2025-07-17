{vars, ...}: {
  home.username = "${vars.user}";
  home.homeDirectory = "/Users/${vars.user}";
  home.stateVersion = "25.05";

  # User specific applications
  home.packages = [];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
  };

  programs.home-manager.enable = true;

  programs = {
    zsh =
      import ../common/modules/home/zsh.nix
      // {
        initContent = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
          eval "$(direnv hook zsh)"
          eval "$(starship init zsh)"
        '';
      };
    starship = import ../common/modules/home/starship.nix;
    git = import ../common/modules/home/git.nix;
    direnv = import ../common/modules/home/direnv.nix;
    alacritty = import ../common/modules/home/alacritty.nix;
    firefox = import ../common/modules/home/firefox.nix;
    bottom = import ../common/modules/home/bottom.nix;
    btop = import ../common/modules/home/btop.nix;
    librewolf = import ../common/modules/home/librewolf.nix;
  };
}
