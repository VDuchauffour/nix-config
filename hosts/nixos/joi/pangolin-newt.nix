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
    EOF
  '';
in {
  services.newt = {
    enable = true;
    environmentFile = config.age.secrets.pangolin-newt.path;
    settings = {
      auth-daemon = true;
    };
  };

  # Trust Pangolin CA for SSH certificate auth
  services.openssh.extraConfig = ''
    TrustedUserCAKeys /etc/ssh/ca.pem
    AuthorizedPrincipalsCommand ${lib.getExe config.services.newt.package} auth-daemon principals --username %u
    AuthorizedPrincipalsCommandUser root
  '';

  systemd.services.newt.serviceConfig = {
    ExecStartPre = ["+${generateBlueprint}"];
    ExecStart = lib.mkForce "${lib.getExe config.services.newt.package} ${
      lib.cli.toCommandLineShellGNU {} (lib.recursiveUpdate config.services.newt.settings {blueprint-file = blueprintPath;})
    }";
  };
}
