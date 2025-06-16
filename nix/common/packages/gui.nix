{pkgs, ...}: {
  packages = with pkgs; [
    # gui
    nautilus
    nautilus-open-any-terminal
    alacritty
    neovide
    galculator
    visual-studio-code

  ];
}

