{
  vars,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    history.size = 10000;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "direnv" "uv" "docker" "kubectl"];
      theme = "robbyrussell";
    };

    shellAliases = {
      ls = "lsd";
      l = "ls";
      ll = "ls -l";
      la = "ls -A";
      lla = "ls -lA";
      lsa = "ls -lA";
      lt = "ls --tree";
      tree = "ls --tree";

      vpn-on = "wg-quick up";
      vpn-off = "wg-quick down";

      k = "kubectl";
      ks = "kubens";
      kx = "kubectx";
      kn = "k9s";

      tf = "terraform";

      open = "xdg-open";
      getmod = "stat --format '%a'";

      matrix = "cmatrix -b -u 4 -a";
    };

    sessionVariables = let
      XDG_BIN_HOME = "$HOME/.local/bin";
    in {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";

      XDG_BIN_HOME = XDG_BIN_HOME;
      PATH = "${XDG_BIN_HOME}:$PATH";
      GTK_THEME = "WhiteSur-Dark";
    };
  };
}
