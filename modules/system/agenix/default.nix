{inputs, ...}: {
  age = {
    secrets = {
      sambaPassword.file = "${inputs.secrets}/secrets/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/secrets/upsPassword.age";
    };
  };
}
