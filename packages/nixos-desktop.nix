{pkgs, ...}:
with pkgs; [
  kitty # because it's the default terminal for hyprland
  # cli tools
  playerctl
  brightnessctl
  avizo # for playerctl, lightctl and volumectl
  wl-clipboard
  gscreenshot

  # apps
  protonvpn-gui
  nautilus
  nautilus-open-any-terminal
  code-nautilus
  viewnior
  papers # pdf viewer of gnome
  gnome-disk-utility
  galculator
  audacious
  audacious-plugins
  mpv
  nwg-displays
  nwg-look
  pavucontrol
  rofi
  networkmanagerapplet
  hypridle
  hyprpaper
  hyprpicker
  chromium
  libreoffice
  rawtherapee
]
