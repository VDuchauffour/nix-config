{
  disko.devices = {
    disk.sd = {
      type = "disk";
      device = "/dev/mmcblk0";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            start = "1M";
            end = "30M";
            label = "FIRMWARE";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/firmware";
              mountOptions = [
                "nofail"
                "noauto"
              ];
            };
          };
          root = {
            size = "100%";
            label = "NIXOS_SD";
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
