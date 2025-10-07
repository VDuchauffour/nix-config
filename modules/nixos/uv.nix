{pkgs, ...}: {
  programs.nix-ld.libraries = with pkgs; [
    uv
  ];
}
