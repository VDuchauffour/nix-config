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
