{
  inputs,
  vars,
  ...
}: {
  age = {
    secrets = {
      emailAddress = {
        file = "${inputs.secrets}/secrets/email-address.age";
        owner = "${vars.userName}";
      };
      publicDomainName = {
        file = "${inputs.secrets}/secrets/public-domain-name.age";
        owner = "${vars.userName}";
      };
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
      pangolin-newt-joi.file = "${inputs.secrets}/secrets/pangolin-newt-joi.age";
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
