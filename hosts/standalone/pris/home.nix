{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  home.homeDirectory = lib.mkForce "/home/${vars.userName}";
}
