{inputs, ...}: {
  age = {
    secrets = {
      publicDomainName = {
        file = "${inputs.secrets}/secrets/public-domain-name.age";
        owner = "k";
      };
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
      pangolin-newt.file = "${inputs.secrets}/secrets/pangolin-newt.age";
      n8n-api-key = {
        file = "${inputs.secrets}/secrets/n8n-api-key.age";
        owner = "k";
      };
      gh-api-key = {
        file = "${inputs.secrets}/secrets/gh-api-key.age";
        owner = "k";
      };
    };
  };
}
