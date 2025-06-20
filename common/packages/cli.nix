{ pkgs, ... }:
with pkgs; [
  # cli tools
  zsh-syntax-highlighting
  zsh-autosuggestions
  direnv
  stow
  make
  coreutils
  openssl
  wget
  aria2
  git
  git-delta
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
  poetry
  uv
  lua-language-server
  stylua
  shellcheck
  shfmt
  terraform
  kubectl
  kubectx
  kubens
  k9s
  kubectl-aliases
  eksctl
  helm
  kubeseal
  awscli2
]
