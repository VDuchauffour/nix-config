{
  # Define a slice that limits CPU/RAM for the whole k3s stack
  systemd.slices."k3s.slice".sliceConfig = {
    MemoryMax = "12G";
    CPUQuota = "800%"; # 8 vCPU, use nproc to see how many vCPU the machine has
  };
  # Ensure both services run inside that slice
  systemd.services.k3s.serviceConfig.Slice = "k3s.slice";
  systemd.services.containerd.serviceConfig.Slice = "k3s.slice";

  networking.firewall.allowedTCPPorts = [80 443];
}
