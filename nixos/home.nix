{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "k";
    homeDirectory = "/home/k";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  programs.git = import ../modules/home/git.nix {inherit pkgs;};
  programs.zsh = import ../modules/home/zsh.nix {inherit pkgs;};
  programs.direnv = import ../modules/home/direnv.nix {inherit pkgs;};
  programs.firefox = import ../modules/home/firefox.nix {inherit pkgs;};
  programs.librewolf = import ../modules/home/librewolf.nix {inherit pkgs;};
  programs.nautilus-open-any-terminal = import ../modules/home/nautilus.nix {inherit pkgs;};
  programs.k9s = import ../modules/home/k9s.nix;

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
