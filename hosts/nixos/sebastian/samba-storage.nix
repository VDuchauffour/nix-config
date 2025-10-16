{vars, ...}: {
  services.samba = {
    settings = {
      media = {
        path = "/tank/media";
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
