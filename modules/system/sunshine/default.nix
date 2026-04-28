{
  services.sunshine = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    capSysAdmin = true;
  };

  # Required for encoding
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
