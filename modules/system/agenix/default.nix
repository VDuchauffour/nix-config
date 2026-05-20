{
  inputs,
  vars,
  ...
}: {
  age = {
    secrets = {
      emailAddress = {
        file = "${inputs.private}/secrets/email-address.age";
        owner = "${vars.userName}";
      };
      publicDomainName = {
        file = "${inputs.private}/secrets/public-domain-name.age";
        owner = "${vars.userName}";
      };
      sambaPassword.file = "${inputs.private}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.private}/secrets/upsPassword.age";

      n8n-api-key = {
        file = "${inputs.private}/secrets/n8n-api-key.age";
        owner = "k";
      };
      gh-api-key = {
        file = "${inputs.private}/secrets/gh-api-key.age";
        owner = "k";
      };
    };
  };
}
