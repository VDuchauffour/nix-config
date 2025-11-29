{pkgs, ...}: {
  imports = [
    ./audio
    ./bluetooth
    ./docker
    ./grub
    ./keyring
    ./locale
    ./network
    ./nix-ld
    ./openssh
    ./power
    ./storage
    ./touchegg
    ./uv
  ];

  environment.systemPackages = with pkgs; (import ../../packages/nixos.nix {inherit pkgs;});
}
