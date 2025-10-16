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
    includes = ["config-ext"];
  };
}
