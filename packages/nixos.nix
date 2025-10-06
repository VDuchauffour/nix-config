{pkgs, ...}:
with pkgs; [
  # cli tools
  playerctl
  brightnessctl
  avizo # for playerctl, lightctl and volumectl
  wl-clipboard
  libsecret
  xdg-user-dirs-gtk

  protonvpn-cli
  protonvpn-gui

  # apps
  nautilus
  nautilus-open-any-terminal
  code-nautilus
  viewnior
  eog # eye of gnome
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
