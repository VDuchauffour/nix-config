{inputs, ...}: {
  age = {
    secrets = {
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
      frpServerAddr.file = "${inputs.secrets}/secrets/frpServerAddr.age";
      frpAuthToken.file = "${inputs.secrets}/secrets/frpAuthToken.age";
      frpDomain.file = "${inputs.secrets}/secrets/frpDomain.age";
    };
  };
}
