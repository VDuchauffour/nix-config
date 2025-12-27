{pkgs, ...}:
with pkgs; [
  # cli tools
  nvd
  nerd-fonts.symbols-only
  zsh-syntax-highlighting
  zsh-autosuggestions
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

  gemini-cli-bin
  claude-code

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
  pnpm
  lua-language-server
  stylua
  lua52Packages.luarocks
  shellcheck
  shfmt

  alejandra
]
