{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
    };
  };
  services.fail2ban.enable = true;
}
