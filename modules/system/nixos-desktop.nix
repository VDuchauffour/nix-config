{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./display
    ./fonts
    ./nautilus
  ];

  environment.systemPackages = with pkgs;
    (import "${inputs.private}/packages/common-desktop.nix" {inherit pkgs;})
    ++ (import "${inputs.private}/packages/nixos-desktop.nix" {inherit pkgs;});
}
