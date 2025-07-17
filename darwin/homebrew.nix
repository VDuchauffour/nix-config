{
  enable = true;
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
    "the-unarchiver"
    "openmtp"
    "alacritty"
    "bitwarden"
    "scroll-reverser"
    "visual-studio-code"
    "cursor"
    "logi-options+"
    "stats"
    "MonitorControl"
  ];
  brews = [
    "mactop"
    "colima"
    "docker"
    "docker-compose"
    "alejandra"
  ];
  taps = [];
  masApps = {};
}
