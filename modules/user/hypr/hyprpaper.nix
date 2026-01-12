{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2;
      wallpaper = [
        {
          "monitor" = "";
          "path" = "$HOME/.nix-config/assets/wallpapers/ocean_sky.jpg";
        }
      ];
    };
  };
}
