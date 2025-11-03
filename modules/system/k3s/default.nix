# see https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/USAGE.md
{vars, ...}: let
  kubeDir = "/home/${vars.userName}/.kube";
in {
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  services.k3s.enable = true;
  services.k3s.role = "server";

  system.activationScripts.k3sKubeconfig = {
    # Optionally depend on something that ensures /etc is populated
    deps = ["etc"];
    text = ''
      set -eu
      install -d -m 700 ${kubeDir}
      # Copy only if changed
      if [ ! -f ${kubeDir}/config ] || ! cmp -s /etc/rancher/k3s/k3s.yaml ${kubeDir}/config; then
        cp /etc/rancher/k3s/k3s.yaml ${kubeDir}/config
        chown ${vars.userName}:users -R ${kubeDir}
        chmod 755 ${kubeDir}
        chmod 600 ${kubeDir}/config
      fi
    '';
  };
}
