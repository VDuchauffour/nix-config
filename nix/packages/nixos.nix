{pkgs, ...}:
with pkgs; [
  # cli tools
  playerctl
  brightnessctl
  avizo # for playerctl, lightctl and volumectl
  wl-clipboard
  libsecret

  # apps
  nautilus
  nautilus-open-any-terminal
  code-nautilus
  galculator
  audacious
  audacious-plugins
  mpv
  nwg-displays
  nwg-look
  pavucontrol
  rofi-wayland
  networkmanagerapplet
  hypridle
  hyprpaper
]
