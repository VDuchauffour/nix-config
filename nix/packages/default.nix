{pkgs, ...}:
with pkgs; [
  # cli tools
  nerd-fonts.symbols-only
  zsh-syntax-highlighting
  zsh-autosuggestions
  xdg-utils
  xdg-user-dirs-gtk
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
  tree-sitter
  nodejs_24
  hadolint
  go

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

  # programming
  pkgconf
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
  kubeseal
  awscli2

  alejandra

  # apps
  alacritty
  neovide
  vscode
  code-cursor
  chromium
  bitwarden
  protonvpn-gui
  rawtherapee
  qbittorrent
  wireguard-tools
  libreoffice
  dbeaver-bin
]
