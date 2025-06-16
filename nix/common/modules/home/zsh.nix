{pkgs, ...}: {
  enable = true;
  history.size = 10000;
  # voir pour zinit
  initExtra = ''
    eval "$(direnv hook zsh)"
  '';
}
