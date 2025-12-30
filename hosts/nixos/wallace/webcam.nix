{
  config,
  pkgs,
  ...
}: {
  boot.extraModulePackages = with config.boot.kernelPackages; [ipu6-drivers];
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6epmtl";
  };
}
