{config, ...}: {
  services.frp.instances.joi = {
    enable = true;
    role = "client";
    environmentFiles = [
      config.age.secrets.frpServerAddr.path
      config.age.secrets.frpAuthToken.path
      config.age.secrets.frpDomain.path
    ];
    settings = {
      serverAddr = "{{ .Envs.FRP_SERVER_ADDR }}";
      serverPort = 7000;
      auth = {
        method = "token";
        token = "{{ .Envs.FRP_AUTH_TOKEN }}";
      };
      proxies = [
        {
          name = "ssh";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 22;
          remotePort = 6000;
        }
        {
          name = "dashboard";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["dashboard.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "dashboard.home.arpa";
        }
        {
          name = "status";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["status.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "status.home.arpa";
        }
        {
          name = "jellyfin";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["jellyfin.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "jellyfin.home.arpa";
        }
        {
          name = "jellyseerr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["jellyseerr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "jellyseerr.home.arpa";
        }
        {
          name = "qbittorrent";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["qbittorrent.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "qbittorrent.home.arpa";
        }
        # {
        #   name = "immich";
        #   type = "http";
        #   localIP = "192.168.1.18";
        #   localPort = 80;
        #   customDomains = ["immich.{{ .Envs.FRP_DOMAIN }}"];
        #   hostHeaderRewrite = "immich.home.arpa";
        # }
        {
          name = "stirling-pdf";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["stirling-pdf.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "stirling-pdf.home.arpa";
        }
        {
          name = "bazarr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["bazarr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "bazarr.home.arpa";
        }
        {
          name = "radarr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["radarr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "radarr.home.arpa";
        }
        {
          name = "sonarr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["sonarr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "sonarr.home.arpa";
        }
        {
          name = "prowlarr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["prowlarr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "prowlarr.home.arpa";
        }
        {
          name = "tdarr";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["tdarr.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "tdarr.home.arpa";
        }
        {
          name = "vibe-kanban";
          type = "http";
          localIP = "192.168.1.18";
          localPort = 80;
          customDomains = ["vibe-kanban.{{ .Envs.FRP_DOMAIN }}"];
          hostHeaderRewrite = "vibe-kanban.home.arpa";
        }
      ];
    };
  };
}
