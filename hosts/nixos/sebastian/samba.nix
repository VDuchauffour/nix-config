{
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  system.activationScripts.samba_user_create = ''
    smb_password=$(cat "${config.age.secrets.sambaPassword.path}")
    echo -e "$smb_password\n$smb_password\n" | ${lib.getExe' pkgs.samba "smbpasswd"} -a -s ${vars.userName}
  '';
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
