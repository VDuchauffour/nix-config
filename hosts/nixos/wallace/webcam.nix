{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ipu6-camera-bins
    # ivsc-firmware
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];

  boot.kernelModules = ["v4l2loopback" "intel-ipu6" "intel-ipu6-isys"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 card_label="IPU6 Virtual Camera" exclusive_caps=1
  '';
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6ep";
  };
  systemd.services.v4l2-relayd-ipu6.enable = false;
}
