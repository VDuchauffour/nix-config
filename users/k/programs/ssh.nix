{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include config-ext
      Host github.com
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/github
    '';
  };
}
