{vars, ...}: {
  enable = true;
  history.size = 10000;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    plugins = ["git" "docker" "direnv" "uv" "poetry"];
    theme = "robbyrussell";
  };

  initContent = ''
    eval "$(starship init zsh)"

    # Load personal secrets
    [[ ! -f ~/.envrc ]] || source ~/.envrc

    ksh() { kubectl exec --stdin --tty "$1" -- /bin/bash; }
  '';

  shellAliases = {
    ls = "lsd";
    l = "ls";
    ll = "ls -l";
    la = "ls -A";
    lla = "ls -lA";
    lsa = "ls -lA";
    lt = "ls --tree";
    tree = "ls --tree";

    vpn-on = "wg-quick up wg0";
    vpn-off = "wg-quick down wg0";

    k = "kubectl";
    ks = "kubens";
    kx = "kubectx";
    kn = "k9s";

    open = "xdg-open";
    getmod = "stat --format '%a'";

    matrix = "cmatrix -b -u 4 -a";
  };

  sessionVariables = let
    XDG_BIN_HOME = "$HOME/.local/bin";
  in {
    EDITOR = "${vars.editor}";
    VISUAL = "${vars.editor}";

    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    XDG_BIN_HOME = XDG_BIN_HOME;
    PATH = "${XDG_BIN_HOME}:$PATH";
  };
}
