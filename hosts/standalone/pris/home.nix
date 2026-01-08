{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  # Standalone home-manager configuration for Ubuntu/non-NixOS Linux
  # Add pris-specific home-manager settings here

  home.homeDirectory = lib.mkForce "/home/${vars.userName}";
}
