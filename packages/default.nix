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
  fzf
  ncdu
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
  unzip
  yt-dlp
  ghostscript
  imagemagick

  # tui tools
  neovim
  lazygit
  ueberzugpp # for yazi, image preview in terminal
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
  pkgs.python3
  uv
  lua-language-server
  stylua
  lua52Packages.luarocks
  shellcheck
  shfmt
  terraform
  terragrunt
  kubectl
  kubectx
  k9s
  # kubectl-aliases
  eksctl
  kubeseal
  awscli2

  alejandra
]
