{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include config-ext
      Host github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/github
    '';
  };
}
