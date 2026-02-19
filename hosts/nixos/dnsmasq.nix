{
  networking.networkmanager.dns = "dnsmasq";
  networking.resolvconf.enable = false;
  services.dnsmasq = {
    enable = true;
    settings = {
      domain = "home.arpa";
      address = [
        "/home.arpa/192.168.1.18" # wildcard for *.home.arpa
        "/opencode.home.arpa/192.168.1.18"
        "/openchamber.home.arpa/192.168.1.18"
      ];
      listen-address = ["127.0.0.1" "192.168.1.18"];
      server = ["1.1.1.1" "1.0.0.1" "/bytel.fr/192.168.1.254"];
    };
  };
}
