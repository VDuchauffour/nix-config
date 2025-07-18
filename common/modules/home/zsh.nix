{
  enable = true;
  history.size = 10000;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    plugins = ["git" "docker"];
    theme = "robbyrussell";
  };

  initContent = ''
    eval "$(direnv hook zsh)"
    eval "$(starship init zsh)"

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
}
