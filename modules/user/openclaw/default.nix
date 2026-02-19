{...}: {
  programs.openclaw = {
    enable = true;
    config = {
      gateway = {
        mode = "local";
        bind = "lan";
        auth = {
          token = "/run/agenix/openclaw-gateway-token";
        };
      };

      # channels = {
      #   telegram = {
      #     tokenFile = "/run/agenix/openclaw-telegram-token";
      #     allowFrom = ["${config.age.secrets.openclaw-telegram-id.path}"];
      #   };
      # };
    };

    bundledPlugins = {
      summarize.enable = true; # Summarize web pages, PDFs, videos
      peekaboo.enable = false; # macOS only (aarch64-darwin)
      poltergeist.enable = false; # Control your macOS UI
      sag.enable = false; # Text-to-speech
      camsnap.enable = false; # Camera snapshots
      gogcli.enable = false; # Google Calendar
      goplaces.enable = false; # Google Places API
      bird.enable = false; # Twitter/X
      sonoscli.enable = false; # Sonos control
      imsg.enable = false; # iMessage
    };
  };
}
