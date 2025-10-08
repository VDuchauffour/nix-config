{pkgs, ...}: {
  environment.systemPackages = with pkgs; (import ../packages/darwin.nix {inherit pkgs;});
}
