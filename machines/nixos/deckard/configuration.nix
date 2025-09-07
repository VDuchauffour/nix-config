{
  config,
  lib,
  pkgs,
  vars,
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

  users.users."${vars.user}" = {
    home = "/home/${vars.user}";
    name = "${vars.user}";
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "audio" "video"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    (import ../../../nix/packages {inherit pkgs;})
    ++ (import ../../../nix/packages/gui.nix {inherit pkgs;})
    ++ [
      playerctl
      brightnessctl
      pavucontrol
      rofi-wayland
      wl-clipboard
      avizo # for playerctl, lightctl and volumectl
      networkmanagerapplet
      hypridle
    ];

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  security.pam.services.hyprlock = {};
  imports = [
    ./hardware-configuration.nix
    ../../../nix/core
    ../../../users/${vars.user}/programs/nautilus.nix
  ];
}
