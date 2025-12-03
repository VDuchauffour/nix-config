{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    extraPackages = with pkgs; [docker-buildx docker-compose];
  };
}
