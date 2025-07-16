{ pkgs, ... }: {
  enable = true;
  history.size = 10000;
  # voir pour zinit
  initContent = ''
    eval "$(direnv hook zsh)"
  '';
}
