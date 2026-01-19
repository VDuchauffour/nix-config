{pkgs, ...}:
with pkgs; [
  # cli tools
  nvd
  nerd-fonts.symbols-only
  zsh-syntax-highlighting
  zsh-autosuggestions
  inxi
  xdg-utils
  direnv
  stow
  gnumake
  coreutils
  wireguard-tools
  openssl
  pwgen
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

  gemini-cli
  claude-code
  # claude-monitor

  pkgconf
  llvm
  gcc
  rustup
  cargo
  pre-commit
  # poetry
  pkgs.python3
  uv
  pyright
  pnpm
  lua-language-server
  stylua
  lua52Packages.luarocks
  shellcheck
  shfmt

  scaleway-cli
  cloud-init

  alejandra
]
