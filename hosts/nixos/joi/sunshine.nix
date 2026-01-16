{pkgs, ...}: {
  environment.systemPackages = [pkgs.steam];
  services.sunshine.settings = {
    "name" = "Steam Big Picture";
    "cmd" = "steam -tenfoot -fullscreen";
    "detached" = false;
  };
  networking.firewall.allowedTCPPorts = [47990];
  networking.firewall.allowedUDPPorts = [47998 48000 51820];
}
