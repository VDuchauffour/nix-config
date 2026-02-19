{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      theme = "github";
      plugin = [
        "oh-my-opencode"
        "@slkiser/opencode-quota"
        "@simonwjackson/opencode-direnv"
        "opencode-scheduler"
      ];
      mcp = {
        nixos = {
          type = "local";
          command = ["uvx" "mcp-nixos"];
          enabled = true;
        };
        docker = {
          type = "local";
          command = ["uvx" "mcp-server-docker"];
          enabled = true;
        };
        kubernetes = {
          type = "local";
          command = ["npx" "-y" "mcp-server-kubernetes"];
          enabled = true;
        };
        # terraform = {
        #   type = "local";
        #   command = ["docker" "run" "-i" "--rm" "hashicorp/terraform-mcp-server"];
        #   enabled = true;
        # };
        # # PostgreSQL schema inspection and queries
        # # Set POSTGRES_URL in your environment (e.g. postgresql://user:pass@postgres.home.arpa:5432/dbname)
        # postgres = {
        #   type = "local";
        #   command = ["sh" "-c" "exec npx -y @modelcontextprotocol/server-postgres \"$POSTGRES_URL\""];
        #   enabled = true;
        # };
        # # Prometheus PromQL queries, metrics, targets
        # # TODO: update PROMETHEUS_URL with your actual subdomain
        # prometheus = {
        #   type = "local";
        #   command = ["uvx" "prometheus-mcp-server"];
        #   enabled = true;
        #   environment = {
        #     PROMETHEUS_URL = "https://prometheus.home.arpa";
        #   };
        # };
        # # Scaleway proxy Docker (Pangolin, CrowdSec, Traefik)
        # "docker-scaleway" = {
        #   type = "local";
        #   command = ["uvx" "mcp-server-docker"];
        #   enabled = true;
        #   environment = {
        #     DOCKER_HOST = "ssh://pris";
        #   };
        # };
        # # Grafana dashboards, datasources, alerts
        # # Set GRAFANA_SERVICE_ACCOUNT_TOKEN in your environment
        # # TODO: update GRAFANA_URL with your actual subdomain
        # grafana = {
        #   type = "local";
        #   command = ["docker" "run" "--rm" "-i" "--network" "host" "-e" "GRAFANA_URL" "-e" "GRAFANA_SERVICE_ACCOUNT_TOKEN" "grafana/mcp-grafana" "-t" "stdio"];
        #   enabled = true;
        #   environment = {
        #     GRAFANA_URL = "https://grafana.home.arpa";
        #   };
        # };
      };
      permission = {
        edit = "allow";
        bash = "allow";
      };
      formatter = {
        ruff.disabled = false;
        uv.disabled = false;
      };
      keybinds = {
        "input_newline" = "shift+return,ctrl+return,alt+return,ctrl+j";
      };
    };
  };
}
