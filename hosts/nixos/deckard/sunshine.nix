{
  vars,
  pkgs,
  ...
}: {
  services.sunshine = {
    settings = {
      sunshine_name = "deckard";

      # VAAPI encoder (Intel Tiger Lake hardware encoding)
      encoder = "vaapi";

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
          name = "Desktop";
          auto-detach = "true";
        }
        {
          name = "Steam Big Picture";
          auto-detach = "true";
          detached = [
            "sudo -u ${vars.userName} setsid steam steam://open/bigpicture"
          ];
          prep-cmd = [
            {
              "do" = "";
              "undo" = "sudo -u ${vars.userName} setsid steam steam://close/bigpicture";
            }
          ];
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
