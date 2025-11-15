{
  config,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "94e6e4ea";

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

  age.identityPaths = [
    "/root/.ssh/agenix"
    # "/etc/ssh/ssh_host_ed25519_key"  # if secrets are also encrypted to host key
  ];

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhWwl9v5H/L422LWcyHsgtFfsyCL/v29lMRQuRgnWgF"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD7sVA3owAZ3+FLv56+PkNa0FoJogZwHuUAftY3G93O"
    ];
  };
  services.openssh.enable = true;
  programs.zsh.enable = true;

  imports = [
    ./hardware.nix
    ./kubernetes.nix
    ./samba.nix
    ./smartd-devices.nix
    ./ups.nix
  ];
}
