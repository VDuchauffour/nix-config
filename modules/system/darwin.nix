{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    (import ../../packages/common-desktop.nix {inherit pkgs;})
    ++ (import ../../packages/darwin.nix {inherit pkgs;});
}
