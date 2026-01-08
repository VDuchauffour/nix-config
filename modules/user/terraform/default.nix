{pkgs, ...}: {
  home.packages = with pkgs; [
    terraform
    terragrunt
    tflint
  ];

  programs.zsh = {
    shellAliases = {
      tf = "terraform";
      tg = "terragrunt";
    };
  };
}
