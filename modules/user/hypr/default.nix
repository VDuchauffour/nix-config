{pkgs, ...}: {
  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpicker.nix
  ];

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];
}
