{
  services.sunshine = {
    enable = true;
    # Sunshine Web UI ➜ http://<server-ip>:47990
    openFirewall = true;
    autoStart = true;
  };

  # Required for encoding
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
