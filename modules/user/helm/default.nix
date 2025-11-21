{
  config,
  lib,
  pkgs,
  ...
}: let
  my-kubernetes-helm = with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-git
        helm-dt
        helm-s3
      ];
    };

  my-helmfile = pkgs.helmfile-wrapped.override {
    inherit (my-kubernetes-helm) pluginsDir;
  };
in {
  home.packages = with pkgs; [
    my-kubernetes-helm
    my-helmfile
    vals
  ];

  programs.zsh.initContent = lib.mkAfter ''
    eval "$(${my-helmfile}/bin/helmfile completion zsh)"
  '';
}
