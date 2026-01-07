{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  system.stateVersion = "26.05";
  networking.hostId = "36c1b69a";

  system.nixos.tags = let
    cfg = config.boot.loader.raspberryPi;
  in [
    "raspberry-pi-${cfg.variant}"
    cfg.bootloader
    config.boot.kernelPackages.kernel.version
  ];

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0XEG7AYdKiTu/DVxnVq22Cvdc3XK56g5oLZVp5uqzW sebastian-github"
    ];
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  environment.systemPackages = with pkgs; (import ../../../packages/nixos.nix {inherit pkgs;});

  # SD image module handles partitioning, so we don't define disko devices
  # Just ensure the filesystem is configured correctly for the sd-image
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = ["noatime"];
  };
  fileSystems."/boot/firmware" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = ["nofail" "noauto"];
  };
}
