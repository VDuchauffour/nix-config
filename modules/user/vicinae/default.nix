{
  inputs,
  pkgs,
  ...
}: {
  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      font = {
        normal = {
          size = 12;
          normal = "Maple Nerd Font";
        };
      };
      theme = {
        light = {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = {
          name = "vicinae-dark";
          icon_theme = "default";
        };
      };
      launcher_window = {
        csd = true;
        opacity = 0.95;
        rounding = 10;
      };
      providers = {
        ssh.preferences = {terminal = "ghostty";};
        vscode-recents.preferences = {
          title = "Visual Studio Code";
          value = "Code";
        };
      };
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      agenda
      bluetooth
      # nix # TODO add token in private repo
      player-pilot
      power-profile
      ssh
      vscode-recents
    ];
  };
}
