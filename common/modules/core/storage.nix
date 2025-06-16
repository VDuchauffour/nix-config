{ pkgs, ... }: {
  services.udisk2.enable = true;
  services.udiskie.enable = true;
  # see https://wiki.nixos.org/wiki/USB_storage_devices
  services.gvfs.enable = true;
}
