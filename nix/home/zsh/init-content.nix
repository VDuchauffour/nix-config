{
  initContent = ''
    eval "$(starship init zsh)"

    # Load personal secrets
    [[ ! -f ~/.envrc ]] || source ~/.envrc

    ksh() { kubectl exec --stdin --tty "$1" -- /bin/bash; }
  '';
}
