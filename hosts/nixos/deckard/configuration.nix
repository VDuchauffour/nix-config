{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "1a2b3c4d";

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # see https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/intel/tiger-lake/default.nix
  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  boot.kernelParams = lib.mkIf (config.hardware.intelgpu.driver == "i915") ["i915.enable_guc=3"];

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMlRJiPvCCb+jOZOp1lXoGV79WfSAl2tXYrDamBUdjcF deckard-github"
    ];
  };

  imports = [
    ./hardware.nix
    ../dnsmasq.nix
    # ./disko.nix
  ];
}
