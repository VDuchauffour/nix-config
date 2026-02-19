{inputs, ...}: {
  age = {
    secrets = {
      publicDomainName.file = "${inputs.secrets}/secrets/public-domain-name.age";
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
      pangolin-newt.file = "${inputs.secrets}/secrets/pangolin-newt.age";
      openclaw-gateway-token.file = "${inputs.secrets}/secrets/openclaw-gateway-token.age";
      openclaw-telegram-token.file = "${inputs.secrets}/secrets/openclaw-telegram-token.age";
      openclaw-telegram-id.file = "${inputs.secrets}/secrets/openclaw-telegram-id.age";
    };
  };
}
