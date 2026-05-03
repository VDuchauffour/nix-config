{
  vars,
  pkgs,
  ...
}: {
  services.sunshine = {
    settings = {
      sunshine_name = "deckard";
      lan_encryption_mode = 0;
      key_rightalt_to_key_win = "enabled";
      system_tray = "disabled";

      # VAAPI encoder (Intel Tiger Lake hardware encoding)
      encoder = "vaapi";

      # High bitrate for text clarity on WiFi 7 LAN
      max_bitrate = 50000;

      # H.264 only — slightly lower encode latency than HEVC on Tiger Lake
      hevc_mode = 1;
      av1_mode = 1;

      # Minimal FEC — WiFi 7 is reliable, 20% default is overkill
      fec_percentage = 5;
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
        {
          name = "Heroic";
          auto-detach = "true";
          detached = [
            "sudo -u ${vars.userName} setsid heroic"
          ];
          prep-cmd = [
            {
              "do" = "";
              "undo" = "sudo -u ${vars.userName} pkill -x heroic";
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
