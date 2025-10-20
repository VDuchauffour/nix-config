{pkgs, ...}: {
  # networking.hostName is handled in flakeHelpers.nix
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];

  networking.wireguard.enable = true;

  # see https://discourse.nixos.org/t/breaking-changes-announcement-for-unstable/17574/85
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-fortisslvpn
    networkmanager-iodine
    networkmanager-l2tp
    networkmanager-openconnect
    networkmanager-openvpn
    networkmanager-sstp
    networkmanager-vpnc
    networkmanager-strongswan
  ];
}
