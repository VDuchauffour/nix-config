{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh.initContent = lib.mkAfter ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

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
