{
  networking.networkmanager.dns = "dnsmasq";
  services.dnsmasq = {
    enable = true;
    servers = ["1.1.1.1" "1.0.0.1"];
    settings = {
      domain = "home.arpa";
      address = ["/home.arpa/192.168.1.18"]; # wildcard for *.home.arpa
      listen-address = ["127.0.0.1" "192.168.1.18"];
      server = ["/bytel.fr/192.168.1.254"];
    };
  };
}
