{
  config,
  lib,
  pkgs,
  vars,
  apple-fonts,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = config.rev or config.dirtyRev or null;
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.optimise = {
    automatic = true;
  };

  users.users."${vars.userName}" = {
    home = "/home/${vars.userName}";
    name = "${vars.userName}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video" "users" "input" "networkmanager"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.seahorse.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    (import ../../../packages {inherit pkgs;})
    ++ (import ../../../packages/nixos.nix {inherit pkgs;});

  fonts = {
    packages =
      (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts))
      ++ (builtins.attrValues apple-fonts.packages.${pkgs.system})
      ++ [pkgs.corefonts];
    fontDir.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  security.pam.services.hyprlock = {};
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common
    ../../../modules/nixos
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    uv
  ];

  networking.firewall.checkReversePath = false;

  # Enable NAT
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    externalInterface = "eth0";
    # internalInterfaces = ["wg0"];
  };
  # Open ports in the firewall
  networking.firewall = {
    allowedTCPPorts = [53];
    allowedUDPPorts = [53 51820];
  };
}
