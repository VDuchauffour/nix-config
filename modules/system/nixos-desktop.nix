{pkgs, ...}: {
  imports = [
    ./display
    ./fonts
    ./nautilus
  ];

  environment.systemPackages = with pkgs;
    (import ../../packages/common-desktop.nix {inherit pkgs;})
    ++ (import ../../packages/nixos-desktop.nix {inherit pkgs;});
}
