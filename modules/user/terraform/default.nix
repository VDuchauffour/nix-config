{pkgs, ...}: {
  home.packages = with pkgs; [
    terraform
    terragrunt
  ];

  programs.zsh = {
    shellAliases = {
      tf = "terraform";
      tg = "terragrunt";
    };
  };
}
