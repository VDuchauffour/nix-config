{
  enable = true;
  global = {
    autoUpdate = true;
    brewfile = false;
    lockfiles = false;
  };
  onActivation = {
    autoUpdate = true;
    upgrade = false;
    cleanup = "uninstall";
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
    "nikitabobko/tap/aerospace"
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
  taps = [];
  masApps = {};
}
