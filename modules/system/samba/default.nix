{config, ...}: {
  services.samba-wsdd.enable = true; # for network discovery by Windows hosts
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
}
