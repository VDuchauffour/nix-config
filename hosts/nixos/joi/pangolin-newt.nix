{config, ...}: {
  services.newt = {
    enable = true;
    environmentFile = config.age.secrets.pangolin-newt.path;
    settings = {};
  };
}
