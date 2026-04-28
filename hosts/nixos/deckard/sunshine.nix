{pkgs, ...}: {
  services.sunshine = {
    settings = {
      sunshine_name = "deckard";

      # VAAPI encoder (Intel Tiger Lake hardware encoding)
      encoder = "vaapi";

      # KMS capture — direct kernel framebuffer access, lowest latency (~1-2ms vs ~5-10ms for X11)
      capture = "kms";

      # High bitrate for text clarity on WiFi 7 LAN
      max_bitrate = 50000;

      # H.264 only — slightly lower encode latency than HEVC on Tiger Lake
      hevc_mode = 1;
      av1_mode = 1;

      # Minimal FEC — WiFi 7 is reliable, 20% default is overkill
      fec_percentage = 5;

      # No encryption on LAN
      lan_encryption_mode = 0;

      # Hide system tray icon
      system_tray = "disabled";
    };
    applications = {
      apps = [
        {
          name = "Steam Big Picture";
          cmd = "${pkgs.steam}/bin/steam steam://open/bigpicture";
          auto-detach = "true";
        }
      ];
    };
  };

  # VAAPI runtime for hardware encoding
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
