{
  config,
  lib,
  pkgs,
  ...
}: {
  services.newt = {
    enable = true;
    environmentFile = config.age.secrets.pangolin-newt-joi.path;
    settings = {
      auth-daemon = true;
    };
    blueprint = {
      private-resources = {
        joi-ssh = {
          name = "joi SSH";
          mode = "host";
          site = "diligent-colorado-chipmunk";
          destination = "localhost";
          tcp-ports = "22";
          alias = "joi.internal";
        };
      };
    };
  };

  # auth-daemon requires root; override upstream DynamicUser and incompatible hardening
  systemd.services.newt = {
    environment.HOME = lib.mkForce "/var/lib/newt";
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      PrivateUsers = lib.mkForce false;
      User = "root";
      Group = "root";
    };
  };

  # Trust Pangolin CA for SSH certificate auth
  services.openssh.extraConfig = ''
    TrustedUserCAKeys /etc/ssh/ca.pem
    AuthorizedPrincipalsCommand ${lib.getExe config.services.newt.package} auth-daemon principals --username %u
    AuthorizedPrincipalsCommandUser root
  '';
}
