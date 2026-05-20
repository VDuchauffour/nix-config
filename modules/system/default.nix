{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [./ssh ./zsh];

  environment.systemPackages = with pkgs; (import "${inputs.private}/packages/default.nix" {inherit pkgs;});

  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
