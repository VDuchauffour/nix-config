{
  config,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "6b0ae97a";

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoPCo3E+ATI/9Fcjgsv5lW2z79E1BpmOyjmGIDPllV0 wallace-github"
    ];
  };

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  environment.variables = {
    # GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # WLR_NO_HARDWARE_CURSORS = "1"; # fixes blank cursor / black screens
    # LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  hardware.enableRedistributableFirmware = true;

  # allows applications to update firmware
  services.fwupd.enable = true;

  # Fingerprint reader support
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  # boot.extraModprobeConfig = ''
  # options i2c-i801 disable_features=0x10
  # '';
  # boot.blacklistedKernelModules = [ "i2c_i801" ];
  # Or force i801_smbus to load first
  # boot.kernelModules = [ "i801_smbus" ];

  boot.kernelParams = [
    "i915.enable_psr=0"
    "quiet"
  ];

  imports = [
    ./hardware.nix
    ../dnsmasq.nix
    ./webcam.nix
  ];
}
