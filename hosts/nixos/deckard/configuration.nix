{
  config,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "1a2b3c4d";

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  services.dnsmasq = {
    enable = true;
    settings = {
      domain = "home.arpa";
      address = ["/home.arpa/192.168.1.18"]; # wildcard for *.home.arpa
      listen-address = ["127.0.0.1" "192.168.1.18"];
    };
  };

  hardware.intelgpu.vaapiDriver = "intel-media-driver";

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
    # ./disko.nix
  ];
}
