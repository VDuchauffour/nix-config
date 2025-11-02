{
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  # Make sure the directories exist early (idempotent)
  systemd.tmpfiles.rules = [
    "d /var/lock/samba - - - -"
    "d /var/lib/samba/private - - - -"
  ];

  # Remove the old activation script if you had one
  system.activationScripts.samba_user_create = lib.mkForce "";

  # Create the Samba user after samba is up
  systemd.services.samba-user-create = {
    description = "Create Samba user from agenix secret";
    after = ["samba.service"];
    wants = ["samba.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {Type = "oneshot";};
    script = ''
      set -euo pipefail
      sp="${config.age.secrets.sambaPassword.path:-}"
      if [ -n "$sp" ] && [ -r "$sp" ]; then
        install -d -m 0755 /var/lock/samba /var/lib/samba/private
        pw="$(cat "$sp")"
        echo -e "$pw\n$pw\n" | ${lib.getExe' pkgs.samba "smbpasswd"} -a -s ${hl.user}
      else
        echo "[samba-user-create] secret missing, skipping" >&2
      fi
    '';
  };

  # or set Password with: smbpasswd -a <user>
  services.samba = {
    settings = {
      media = {
        path = "/mnt/tank/media";
        browsable = "yes";
        public = "no";
        writeable = "yes";
        "guest ok" = "no";
        "valid users" = vars.userName;
        "force user" = vars.userName;
        "force group" = "users";
        "create mask" = "0755";
        "directory mask" = "0775";
      };
    };
  };
}
