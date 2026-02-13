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

  my-helmfile = pkgs.writeShellScriptBin "helmfile" ''
    export HELM_PLUGINS=${my-kubernetes-helm.pluginsDir}
    exec ${pkgs.helmfile}/bin/helmfile "$@"
  '';
in {
  home.packages = with pkgs; [
    kubectl
    kubectx
    kubeseal
    kubectl-cnpg
    mkcert
    my-kubernetes-helm
    my-helmfile
    vals
  ];

  programs.zsh = {
    initContent = lib.mkAfter ''
      eval "$(${my-helmfile}/bin/helmfile completion zsh)"
    '';
    shellAliases = {
      k = "kubectl";
      ks = "kubens";
      kx = "kubectx";
      kn = "k9s";
    };
  };

  programs.k9s = {
    enable = true;
    aliases = {
      dp = "deployments";
      sec = "secrets";
      jo = "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies";
      svc = "services";
      ing = "ingresses";
      pvc = "persistentvolumeclaims";
      pv = "persistentvolumes";
      ns = "namespaces";
      cm = "configmaps";
      sa = "serviceaccounts";
    };
    views = {
      "v1/pods" = {
        sortColumn = "NAME:asc";
        columns = [
          "NAME"
          "AGE"
          "STATUS"
          "READY"
        ];
      };
      "v1/services" = {
        sortColumn = "NAME:asc";
        columns = [
          "NAME"
          "AGE"
          "TYPE"
          "CLUSTER-IP"
        ];
      };
    };
    settings = {
      logger = {
        tail = 500;
        buffer = 5000;
        sinceSeconds = -1;
        fullScreen = false;
        textWrap = true;
        showTime = false;
      };
    };
  };
}
