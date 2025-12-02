{
  programs.ssh = {
    extraConfig = ''
      Host github.com
        HostName github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/github
    '';
  };
}
