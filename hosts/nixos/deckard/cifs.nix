{
  config,
  pkgs,
  vars,
  ...
}: {
  environment.systemPackages = [pkgs.cifs-utils];

  systemd.services.smb-credentials = {
    description = "Generate SMB credentials file from agenix secret";
    wantedBy = ["multi-user.target"];
    before = ["remote-fs.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      smb_password=$(cat "${config.age.secrets.sambaPassword.path}")
      if [ -n "$smb_password" ]; then
        mkdir -p /run/smb-credentials
        printf 'username=${vars.userName}\npassword=%s\n' "$smb_password" \
          > /run/smb-credentials/joi
        chmod 600 /run/smb-credentials/joi
        echo "[smb-credentials] done"
      else
        echo "[smb-credentials] secret missing, skipping" >&2
        exit 1
      fi
    '';
  };

  fileSystems."/mnt/joi/media" = {
    device = "//192.168.1.18/media";
    fsType = "cifs";
    options = [
      "credentials=/run/smb-credentials/joi"
      "uid=1000"
      "gid=100"
      "file_mode=0644"
      "dir_mode=0755"
      "noauto" # do not mount at boot
      "soft" # return error instead of hanging if server is unreachable
      "x-systemd.automount" # mount on first access
      "x-systemd.idle-timeout=60" # unmount after 60s of inactivity
      "x-systemd.device-timeout=5s" # give up waiting for device after 5s
      "x-systemd.mount-timeout=5s" # give up mounting after 5s
    ];
  };
}
