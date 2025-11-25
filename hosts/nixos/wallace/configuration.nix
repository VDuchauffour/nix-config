{
  config,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "6b0ae97a";

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoPCo3E+ATI/9Fcjgsv5lW2z79E1BpmOyjmGIDPllV0"
    ];
  };
  programs.zsh.enable = true;

  # hardware.ipu6 = {
  #   enable = true;
  #   platform = "ipu6ep";
  # };
  # hardware.enableRedistributableFirmware = true;

  imports = [
    ./hardware.nix
    ./nvidia.nix
  ];
}
