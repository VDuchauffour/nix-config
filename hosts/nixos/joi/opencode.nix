{
  pkgs,
  vars,
  ...
}: let
  opencodePort = 14096;
  opencodeWebPort = 14097;
  openchamberPort = 14098;
  listenHost = "0.0.0.0";
  homeDir = "/home/${vars.userName}";
in {
  networking.firewall.allowedTCPPorts = [opencodePort opencodeWebPort openchamberPort];

  # Headless OpenCode API server
  # Used by openchamber (and any other SDK client)
  systemd.services.opencode-serve = {
    description = "OpenCode headless API server";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = vars.userName;
      Group = "users";
      WorkingDirectory = homeDir;
      ExecStart = "${pkgs.opencode}/bin/opencode serve --port ${toString opencodePort} --hostname ${listenHost}";
      Restart = "on-failure";
      RestartSec = 5;
    };
    environment = {
      HOME = homeDir;
      # OPENCODE_SERVER_PASSWORD = "changeme"; # TODO: use agenix
    };
  };

  # OpenCode built-in web UI (starts its own server instance)
  systemd.services.opencode-web = {
    description = "OpenCode web interface";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = vars.userName;
      Group = "users";
      WorkingDirectory = homeDir;
      ExecStart = "${pkgs.opencode}/bin/opencode web --port ${toString opencodeWebPort} --hostname ${listenHost}";
      Restart = "on-failure";
      RestartSec = 5;
    };
    environment = {
      HOME = homeDir;
      # OPENCODE_SERVER_PASSWORD = "changeme"; # TODO: use agenix
    };
  };

  # OpenChamber fan-made web UI, connects to the headless opencode-serve instance
  systemd.services.openchamber = {
    description = "OpenChamber web UI for OpenCode";
    after = ["network.target" "opencode-serve.service"];
    requires = ["opencode-serve.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      User = vars.userName;
      Group = "users";
      WorkingDirectory = homeDir;
      Restart = "on-failure";
      RestartSec = 5;
    };
    script = ''
      exec ${pkgs.openchamber}/bin/openchamber --port ${toString openchamberPort}
    '';
    environment = {
      HOME = homeDir;
      OPENCODE_PORT = toString opencodePort;
      OPENCODE_SKIP_START = "true";
    };
  };
}
