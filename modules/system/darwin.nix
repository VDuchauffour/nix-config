{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    (import "${inputs.private}/packages/common-desktop.nix" {inherit pkgs;})
    ++ (import "${inputs.private}/packages/darwin.nix" {inherit pkgs;});
}
