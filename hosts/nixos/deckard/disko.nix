{
  disko.devices = {
    disk.nvme = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";
        partitions = {
          esp = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
              format = "vfat";
            };
          };
          msr = {
            type = "0C01"; # MSR partition type
            size = "16M";
          };
          windows = {
            type = "0700"; # Microsoft basic data
            size = "268G";
            content = {
              type = "filesystem";
              format = "ntfs";
            };
          };
          winre = {
            type = "2700"; # Windows recovery
            size = "951M";
            content = {
              type = "filesystem";
              format = "ntfs";
            };
          };
          swap = {
            type = "8200"; # Linux swap
            size = "25G";
            content = {
              type = "swap";
            };
          };
          nixos = {
            type = "8300";
            size = "659G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = ["noatime"];
            };
          };
        };
      };
    };
  };
}
