{inputs, ...}: {
  age = {
    secrets = {
      sambaPassword.file = "${inputs.secrets}/sambaPassword.age";
      upsPassword.file = "${inputs.secrets}/upsPassword.age";
    };
  };
}
