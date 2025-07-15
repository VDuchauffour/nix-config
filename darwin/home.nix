{ vars
, gecko
, ...
}: {
  home.username = "${vars.user}";
  home.homeDirectory = "/Users/${vars.user}";
  home.stateVersion = "25.11";

  # User specific applications
  home.packages = [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".zshrc".source = ~/dotfiles/zshrc/.zshrc;
  };

  system.defaults = (import ./system.nix { inherit vars; }).defaults;
  programs.home-manager.enable = true;

  programs.librewolf = {
    enable = true;
    settings = gecko.librewolf.settings;
    extensions = gecko.extensions;
  };
}
