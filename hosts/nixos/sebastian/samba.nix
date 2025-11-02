{
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  systemd.services.samba-user-create = {
    description = "Create Samba user from agenix secret on first boot";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ConditionFirstBoot = true;
    };
    script = ''
      set -euo pipefail
      smb_password="${config.age.secrets.sambaPassword.path:-}"
      if [ -n "$smb_password" ] && [ -r "$smb_password" ]; then
        smb_password=$(cat "${config.age.secrets.sambaPassword.path}")
        echo -e "$smb_password\n$smb_password\n" | ${lib.getExe' pkgs.samba "smbpasswd"} -a -s ${vars.userName}
        echo "[samba-user-create] done"
      else
        echo "[samba-user-create] secret missing, skipping" >&2
        exit 1
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
