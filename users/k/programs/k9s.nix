{
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
