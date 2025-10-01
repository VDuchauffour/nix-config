{pkgs, ...}:
with pkgs; [
  # cli tools
  playerctl
  brightnessctl
  avizo # for playerctl, lightctl and volumectl
  wl-clipboard
  libsecret
  xdg-user-dirs-gtk

  # apps
  nautilus
  nautilus-open-any-terminal
  code-nautilus
  viewnior
  eog # eye of gnome
  papers # pdf viewer of gnome
  gnome-disk-utility # disk utility of gnome
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
  protonvpn-gui
  libreoffice
  rawtherapee
]
