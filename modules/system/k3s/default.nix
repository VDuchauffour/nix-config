# see https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/USAGE.md
{
  pkgs,
  vars,
  ...
}: let
  kubeDir = "/home/${vars.userName}/.kube";
  cmpBin = "${pkgs.diffutils}/bin/cmp";
  ipBin = "${pkgs.iproute2}/bin/ip";
  awkBin = "${pkgs.gawk}/bin/awk";
  sedBin = "${pkgs.gnused}/bin/sed";
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

      if [ ! -f ${kubeDir}/config ] || ! ${cmpBin} -s /etc/rancher/k3s/k3s.yaml ${kubeDir}/config; then
        cp /etc/rancher/k3s/k3s.yaml ${kubeDir}/config
        chmod 755 ${kubeDir}
        chmod 600 ${kubeDir}/config
      fi

      # Compute primary IPv4 via routing table (no DNS needed)
      if ${ipBin} -o -4 route get 1.1.1.1 >/dev/null 2>&1; then
        PRIMARY_IP="$(${ipBin} -o -4 route get 1.1.1.1 | ${awkBin} '{for(i=1;i<=NF;i++){if($i=="src"){print $(i+1); exit}}}')"
        if [ -n "$PRIMARY_IP" ]; then
          cp ${kubeDir}/config ${kubeDir}/config.remote
          ${sedBin} -i "s#server: https://127.0.0.1:6443#server: https://$PRIMARY_IP:6443#" ${kubeDir}/config.remote
          chmod 600 ${kubeDir}/config.remote
        fi
      fi

      chown ${vars.userName}:users -R ${kubeDir}
    '';
  };
}
