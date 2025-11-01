{pkgs, ...}: {
  imports = [
    ./audio
    ./bluetooth
    ./bootloader
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

  environment.systemPackages = with pkgs; (import ../../packages/nixos.nix {inherit pkgs;});
}
