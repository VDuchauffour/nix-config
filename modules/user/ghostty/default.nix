{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      theme = "Tomorrow Night Bright";
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor,ssh-env,ssh-terminfo";
      copy-on-select = "clipboard";
      clipboard-read = "allow";
      clipboard-write = "allow";
      selection-clear-on-copy = false;
      maximize = true;
      window-theme = "ghostty";
      macos-titlebar-style = "hidden";
      window-decoration = "none";
      window-padding-balance = true;
      window-padding-x = 0;
      window-padding-y = 0;
      window-padding-color = "extend";
      window-titlebar-background = "#000000";
      window-titlebar-foreground = "#FFFFFF";
      font-family = "JetBrainsMonoNL Nerd Font";
      font-style = "Regular";
      font-style-bold = "Bold";
      font-style-italic = "Italic";
      font-style-bold-italic = "SemiBold Italic";
      confirm-close-surface = false;
    };
  };
}
