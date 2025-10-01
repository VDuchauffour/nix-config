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
    "openmtp"
    "scroll-reverser"
    "logi-options+"
    "logitech-g-hub"
    "stats"
    "MonitorControl"
    "utm"
    "macfuse"
    "fuse-t"
    "slack"
    "aerospace"
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
  ];
  taps = [
    "nikitabobko/tap"
  ];
  masApps = {};
}
