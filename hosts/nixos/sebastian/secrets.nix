{inputs, ...}: {
  age = {
    secrets = {
      sambaPassword.file = "${inputs.secrets}/sebastian/sambaPassword.age";
    };
  };
}
