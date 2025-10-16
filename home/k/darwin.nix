{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh.initContent = lib.mkAfter ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  programs.ssh.matchBlocks."*".extraOptions = {
    "UseKeychain" = "yes";
  };
}
