{
  config,
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostId = "94e6e4ea";

  age.identityPaths = [
    "/root/.ssh/agenix"
    # "/etc/ssh/ssh_host_ed25519_key"  # if secrets are also encrypted to host key
  ];

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "render" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhWwl9v5H/L422LWcyHsgtFfsyCL/v29lMRQuRgnWgF"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD7sVA3owAZ3+FLv56+PkNa0FoJogZwHuUAftY3G93O"
    ];
  };
  services.openssh.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = [pkgs.steam];
  services.sunshine.settings = {
    "name" = "Steam Big Picture";
    "cmd" = "steam -tenfoot -fullscreen";
    "detached" = false;
  };
  networking.firewall.allowedTCPPorts = [47990];
  networking.firewall.allowedUDPPorts = [47998 48000];

  imports = [
    ./hardware.nix
    ./kubernetes.nix
    ./samba.nix
    ./smartd-devices.nix
    ./ups.nix
    ./virtual-display.nix
    ./zfs.nix
  ];
}
