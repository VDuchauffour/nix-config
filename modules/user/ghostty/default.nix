{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      theme = "Tomorrow Night Bright";
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor";
      copy-on-select = "clipboard";
      selection-clear-on-copy = false;
      font-family = "JetBrainsMonoNL Nerd Font";
      font-style = "Regular";
      font-style-bold = "Bold";
      font-style-italic = "Italic";
      font-style-bold-italic = "SemiBold Italic";
    };
  };
}
