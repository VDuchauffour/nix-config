{
  lib,
  config,
  pkgs,
  vars,
  ...
}: {
  networking.firewall = {
    enable = true;
  };
  # system.activationScripts.samba_user_create = ''
  #   smb_password=$(cat "${config.age.secrets.sambaPassword.path}")
  #   echo -e "$smb_password\n$smb_password\n" | ${lib.getExe' pkgs.samba "smbpasswd"} -a -s ${vars.userName}
  # '';
  services.samba-wsdd.enable = true; # for network discovery by Windows hosts
  # Set Password with: smbpasswd -a <user>
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = config.networking.hostName;
        "netbios name" = config.networking.hostName;
        "security" = "user";
        "invalid users" = ["root"];
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
}
