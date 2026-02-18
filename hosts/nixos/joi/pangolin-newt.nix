{config, ...}: {
  services.newt = {
    enable = true;
    environmentFile = config.age.secrets.pangolin-newt.path;
    settings = {
      endpoint = "{{ .Envs.ENDPOINT }}";
      id = "{{ .Envs.ID }}";
      secret = "{{ .Envs.SECRET }}";
    };
  };
}
