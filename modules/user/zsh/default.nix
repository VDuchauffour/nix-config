{
  vars,
  pkgs,
  ...
}: let
  kvalsScript = pkgs.writeText "kvals.sh" (builtins.readFile ./kvals.sh);
in {
  programs.zsh = {
    enable = true;
    history.size = 10000;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "direnv" "uv" "docker" "kubectl" "helm"];
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

      open = "xdg-open";
      getmod = "stat --format '%a'";

      matrix = "cmatrix -b -u 4 -a";
    };

    sessionVariables = let
      XDG_BIN_HOME = "$HOME/.local/bin";
      EDITOR = "nvim";
    in {
      EDITOR = EDITOR;
      VISUAL = EDITOR;

      XDG_BIN_HOME = XDG_BIN_HOME;
      PATH = "${XDG_BIN_HOME}:$PATH";
      GTK_THEME = "WhiteSur-Dark";

      TERM = "xterm-256color";

      GOPATH = "$HOME/.go";
    };

    initContent = ''
      eval "$(starship init zsh)"

      # Load personal secrets
      [[ ! -f ~/.envrc ]] || source ~/.envrc

      ksh() { kubectl exec --stdin --tty "$1" -- /bin/bash; }

      source ${kvalsScript}
    '';
  };
}
