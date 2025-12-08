{
  pkgs,
  lib,
  apple-fonts,
  ...
}: {
  fonts = {
    packages =
      (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts))
      ++ (builtins.attrValues apple-fonts.packages.${pkgs.stdenv.hostPlatform.system})
      ++ [pkgs.corefonts];
    fontDir.enable = true;
  };
}
