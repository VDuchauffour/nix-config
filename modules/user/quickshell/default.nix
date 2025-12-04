{
  programs.quickshell = {
    enable = true;
    activeConfig = "$XDG_CONFIG_HOME/.config/quickshell";
    systemd.enable = true;
  };
}
