{pkgs, ...}:
with pkgs; [
  # cli tools
  nerd-fonts.symbols-only
  zsh-syntax-highlighting
  zsh-autosuggestions
  xdg-utils
  direnv
  stow
  gnumake
  coreutils
  openssl
  wget
  aria2
  git
  delta
  gh
  bat
  dust
  duf
  doggo
  ripgrep
  lsd
  fd
  sd
  xh
  jq
  jless
  imagemagick
  tldr

  # tui tools
  neovim
  fzf
  ranger
  lazygit
  htop
  bottom
  procs
  sysz
  sshs
  tmux
  k9s

  # programming
  llvm
  gcc
  rustup
  cargo
  pre-commit
  poetry
  uv
  lua-language-server
  stylua
  shellcheck
  shfmt
  terraform
  kubectl
  kubectx
  k9s
  # kubectl-aliases
  eksctl
  kubernetes-helm
  kubeseal
  awscli2
]
