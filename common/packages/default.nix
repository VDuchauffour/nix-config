{pkgs, ...}: {
  cli = import ./cli.nix {inherit pkgs;};
  gui = import ./gui.nix {inherit pkgs;};
}
