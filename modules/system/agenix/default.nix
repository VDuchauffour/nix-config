{inputs, ...}: {
  age = {
    secrets = {
      publicDomainName.file = "${inputs.secrets}/secrets/public-domain-name.age";
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
      pangolin-newt.file = "${inputs.secrets}/secrets/pangolin-newt.age";
    };
  };
}
