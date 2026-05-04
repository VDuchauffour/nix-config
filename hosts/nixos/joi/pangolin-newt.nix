{
  config,
  lib,
  pkgs,
  ...
}: let
  # Runtime-rendered blueprint: the upstream YAML lives in the world-readable
  # nix store, so the email is inserted at service start instead of build time.
  runtimeBlueprint = "/run/newt/blueprint.yml";
in {
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
          # Placeholder substituted at runtime by ExecStartPre below with the
          # value of the agenix-encrypted `emailAddress` secret.
          users = ["\${EMAIL_ADDRESS}"];
          alias = "joi.internal";
        };
      };
    };
  };

  # auth-daemon requires root; override upstream DynamicUser and incompatible hardening
  systemd.services.newt = let
    cfg = config.services.newt;
    storeBlueprint = (pkgs.formats.yaml {}).generate "blueprint.yml" cfg.blueprint;
    runtimeSettings = cfg.settings // {blueprint-file = runtimeBlueprint;};
  in {
    after = ["agenix.service"];
    environment.HOME = lib.mkForce "/var/lib/newt";
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      PrivateUsers = lib.mkForce false;
      User = "root";
      Group = "root";
      RuntimeDirectory = "newt";
      RuntimeDirectoryMode = "0700";

      # Render the blueprint at start, substituting the agenix-decrypted email
      # into the ${EMAIL_ADDRESS} placeholder. Whitelisting the variable name
      # prevents envsubst from touching anything else in the YAML.
      ExecStartPre = pkgs.writeShellScript "newt-render-blueprint" ''
        set -eu
        export EMAIL_ADDRESS="$(cat ${config.age.secrets.emailAddress.path})"
        ${pkgs.envsubst}/bin/envsubst '$EMAIL_ADDRESS' \
          < ${storeBlueprint} > ${runtimeBlueprint}
        chmod 600 ${runtimeBlueprint}
      '';

      # Override upstream ExecStart so newt reads the runtime-rendered file
      # instead of the placeholder copy in the nix store.
      ExecStart = lib.mkForce "${lib.getExe cfg.package} ${
        lib.cli.toCommandLineShellGNU {} runtimeSettings
      }";
    };
  };

  # Trust Pangolin CA for SSH certificate auth
  services.openssh.extraConfig = ''
    TrustedUserCAKeys /etc/ssh/ca.pem
    AuthorizedPrincipalsCommand ${lib.getExe config.services.newt.package} auth-daemon principals --username %u
    AuthorizedPrincipalsCommandUser root
  '';
}
