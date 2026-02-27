{
  pkgs,
  vars,
  ...
}: let
  opencodeWebPort = 14097;
  openchamberPort = 14098;
  listenHost = "0.0.0.0";
  homeDir = "/home/${vars.userName}";
in {
  networking.firewall.allowedTCPPorts = [opencodeWebPort openchamberPort];
  # OpenCode built-in web UI (embeds its own API server)
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

  # OpenChamber fan-made web UI, connects to opencode-web's embedded server
  systemd.services.openchamber = {
    description = "OpenChamber web UI for OpenCode";
    after = ["network.target" "opencode-web.service"];
    requires = ["opencode-web.service"];
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
      OPENCODE_PORT = toString opencodeWebPort;
      OPENCODE_SKIP_START = "true";
    };
  };
}
