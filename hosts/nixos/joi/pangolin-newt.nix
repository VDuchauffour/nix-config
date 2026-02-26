{
  config,
  lib,
  pkgs,
  ...
}: let
  domainSecret = config.age.secrets.publicDomainName.path;
  blueprintPath = "/run/newt/blueprint.yml";

  generateBlueprint = pkgs.writeShellScript "newt-generate-blueprint" ''
    DOMAIN=$(cat "${domainSecret}")
    mkdir -p /run/newt
    install -m 0644 /dev/null "${blueprintPath}"
    cat > "${blueprintPath}" <<EOF
    proxy-resources:
      opencode:
        name: OpenCode
        protocol: http
        full-domain: opencode.$DOMAIN
        targets:
          - hostname: localhost
            port: 14097
            method: http
            healthcheck:
              hostname: localhost
              port: 14097
              enabled: true
              path: /
              interval: 30
              timeout: 5
      openchamber:
        name: OpenChamber
        protocol: http
        full-domain: openchamber.$DOMAIN
        targets:
          - hostname: localhost
            port: 14098
            method: http
            healthcheck:
              hostname: localhost
              port: 14098
              enabled: true
              path: /
              interval: 30
              timeout: 5
    EOF
  '';
in {
  services.newt = {
    enable = true;
    environmentFile = config.age.secrets.pangolin-newt.path;
    settings = {};
  };

  systemd.services.newt.serviceConfig = {
    ExecStartPre = ["+${generateBlueprint}"];
    ExecStart = lib.mkForce "${lib.getExe config.services.newt.package} ${
      lib.cli.toCommandLineShellGNU {} (lib.recursiveUpdate config.services.newt.settings {blueprint-file = blueprintPath;})
    }";
  };
}
