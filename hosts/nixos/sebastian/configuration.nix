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
  boot.zfs.extraPools = ["storage"];
  boot.kernelParams = ["zfs.zfs_arc_max=17179869184"]; # 16GB of RAM for ARC cache

  fileSystems."/mnt/storage" = {
    device = "storage";
    fsType = "zfs";
  };

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFV5qP4VYazqQcca7jxvMH1Wulbl7MS+5C7rKjyyGf2J personal"
    ];
  };
  services.openssh.enable = true;
  programs.zsh.enable = true;

  imports = [
    ./hardware.nix
    ./samba-storage.nix
    ./smartd-devices.nix
  ];
}
