{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./audio
    ./bluetooth
    ./docker
    ./keyring
    ./locale
    ./network
    ./nix-ld
    ./power
    ./storage
    ./touchegg
    ./uv
  ];

  environment.systemPackages = with pkgs; (import "${inputs.private}/packages/nixos.nix" {inherit pkgs;});
}
