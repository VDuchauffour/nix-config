{
  pkgs,
  lib,
  ...
}: {
  imports = [./nix ./ssh ./zsh];

  environment.systemPackages = with pkgs; (import ../../packages {inherit pkgs;});

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
