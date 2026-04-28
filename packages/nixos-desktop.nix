{pkgs, ...}:
with pkgs; [
  kitty # because it's the default terminal for hyprland
  # cli tools
  playerctl
  brightnessctl
  avizo # for playerctl, lightctl and volumectl
  wl-clipboard
  gscreenshot
  exiftool

  # apps
  proton-vpn
  nautilus
  nautilus-open-any-terminal
  code-nautilus
  viewnior
  gnome-disk-utility
  gnome-calculator
  audacious
  audacious-plugins
  mpv
  nwg-displays
  nwg-look
  pavucontrol
  pwvucontrol
  networkmanagerapplet
  hypridle
  hyprpaper
  hyprpicker
  libreoffice
  rawtherapee
  rapidraw
  picard
  gelly
  rquickshare
]
