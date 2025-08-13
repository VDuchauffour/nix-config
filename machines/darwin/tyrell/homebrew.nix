{
  enable = true;
  global = {
    autoUpdate = true;
    brewfile = false;
    lockfiles = false;
  };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
  brewPrefix = "/opt/homebrew/bin";
  caskArgs = {
    no_quarantine = true;
  };
  casks = [
    "iina"
    "chromium"
    "openmtp"
    "alacritty"
    "bitwarden"
    "scroll-reverser"
    "visual-studio-code"
    "cursor"
    "logi-options+"
    "logitech-g-hub"
    "stats"
    "MonitorControl"
    "protonvpn"
    "qbittorrent"
    "utm"
    "macfuse"
    "fuse-t"
    "libreoffice"
    "slack"
    "aws-vpn-client"
    "aerospace"
    "dbeaver-community"
  ];
  brews = [
    "mactop"
    "colima"
    "docker"
    "docker-compose"
    "docker-buildx"
    "docker-completion"
    "docker-clean"
    "alejandra"
    "pkgconf"
  ];
  taps = [
    "nikitabobko/tap"
  ];
  masApps = {};
}
