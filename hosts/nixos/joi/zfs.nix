{
  boot.loader.grub.zfsSupport = true;
  boot.supportedFilesystems = ["zfs"];
  # boot.zfs.extraPools = ["tank"];
  boot.kernelParams = ["zfs.zfs_arc_max=17179869184"]; # 16GB of RAM for ARC cache

  # we need to declare manually a legacy mountpoint
  fileSystems."/mnt/tank" = {
    device = "tank";
    fsType = "zfs";
  };
  fileSystems."/mnt/tank/media" = {
    device = "tank/media";
    fsType = "zfs";
  };
  fileSystems."/vm-pool" = {
    device = "vm-pool";
    fsType = "zfs";
  };
}
