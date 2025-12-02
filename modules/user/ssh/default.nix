{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {};
      "github.com" = {
        hostname = "github.com";
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/github";
      };
    };
    includes = ["config-ext" "config-devpod"];
  };
  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
