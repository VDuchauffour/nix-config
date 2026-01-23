{
  pkgs,
  vars,
  ...
}: {
  system.stateVersion = "26.05";
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhWwl9v5H/L422LWcyHsgtFfsyCL/v29lMRQuRgnWgF deckard-joi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzPLxiLl8HM9Oa8o00IAyp8pKQMWEFUmfk3aOzyCpQn wallace-joi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKSNlbZcFTZXv0PPAFdIO7zD0GdOIGxLY9z1Q7UYxfBO luv-joi"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD7sVA3owAZ3+FLv56+PkNa0FoJogZwHuUAftY3G93O joi-github"
    ];
  };
  services.openssh.enable = true;

  imports = [
    ../dnsmasq.nix
    ./frpc.nix
    ./graphics.nix
    ./hardware.nix
    ./kubernetes.nix
    ./samba.nix
    ./smartd-devices.nix
    ./sunshine.nix
    ./ups.nix
    ./virtual-display.nix
    ./zfs.nix
  ];
}
